#!/bin/bash

# 自动检查最新的kcp客户端
# 自动下载到$HOME/.kcptun 目录
# 因为需要访问github，Amazon等网址，所以必须添加翻墙代理才能更新

DOWNLOAD_DIR=$HOME/Downloads
KCPTUN_INSTALL_DIR=$HOME/.kcptun # kcptun 默认安装目录
KCPTUN_RELEASES_URL="https://api.github.com/repos/xtaci/kcptun/releases"
FILE_SUFFIX="darwin_amd64"
SPRUCE_TYPE="darwin-amd64"
HTTP_PROXY="127.0.0.1:1087"
JQ=/usr/local/bin/jq

# 检查当前用户是否拥有管理员权限
permission_check() {
	if [ $EUID -ne 0 ]; then
		cat >&2 <<-'EOF'

		权限错误, 请使用 root 用户运行此脚本!
		EOF
		exit 1
	fi
}

get_installed_version() {
	cat >&2 <<-'EOF'

	正在获取当前安装的 Kcptun 信息...
	EOF

	local kcptun_client_exec="$KCPTUN_INSTALL_DIR"/client_"$FILE_SUFFIX"
	if [ -x "$kcptun_client_exec" ]; then
		installed_kcptun_version=$(${kcptun_client_exec} -v | awk '{printf $3}')
	else
		unset installed_kcptun_version
		cat >&2 <<-'EOF'

		未找到 Kcptun 客户端执行文件
		开始安装 Kcptun 客户端
		EOF
		install_kcptun
	fi
}

# 安装 Json 解析工具 JQ
install_jq() {
	cat >&2 <<-'EOF'

	正在安装 Json 解析工具 jq ...
	EOF
	brew install jq
}


get_kcptun_version_info() {
	cat >&2 <<-'EOF'

	正在获取网络信息...
	EOF

	[ ! -x "$JQ" ] && install_jq

	local request_version=$1
	local kcptun_release_content

	if [ -n "$request_version" ]; then
		kcptun_release_content=$(curl --proxy $HTTP_PROXY --silent --insecure --fail $KCPTUN_RELEASES_URL | $JQ -r ".[] | select(.tag_name == \"${request_version}\")")
	else
		kcptun_release_content=$(curl --proxy $HTTP_PROXY --silent --insecure --fail $KCPTUN_RELEASES_URL | $JQ -r ".[0]")
	fi

	if [ -n "$kcptun_release_content" ]; then
		kcptun_release_name=$($JQ -r ".name" <<< "$kcptun_release_content")
		kcptun_release_tag_name=$($JQ -r ".tag_name" <<< "$kcptun_release_content")
		kcptun_release_prerelease=$($JQ -r ".prerelease" <<< "$kcptun_release_content")
		kcptun_release_html_url=$($JQ -r ".html_url" <<< "$kcptun_release_content")

		kcptun_release_download_url=$($JQ -r ".assets[] | select(.name | contains(\"$SPRUCE_TYPE\")) | .browser_download_url" <<< "$kcptun_release_content" | head -n 1) || {
			cat >&2 <<-'EOF'

			获取 Kcptun 下载地址失败, 请重试...
			EOF
			exit 1
		}
	else
		if [ -n "$request_version" ]; then
			return 2
		else
			cat >&2 <<-'EOF'

			获取 Kcptun 版本信息失败, 请检查你的网络连接!
			注意：请检查是否开启 shadowsocks http 代理 127.0.0.1:1087
			EOF
			exit 1
		fi
	fi
}

# 任意键继续
any_key_to_continue() {
	SAVEDSTTY=`stty -g`
	stty -echo
	stty cbreak
	dd if=/dev/tty bs=1 count=1 2> /dev/null
	stty -raw
	stty echo
	stty $SAVEDSTTY
}

# 下载文件
download_file(){
	cat >&2 <<-'EOF'

	开始下载文件...
	EOF

	cd "$DOWNLOAD_DIR"
	if [ `pwd` != "$DOWNLOAD_DIR" ]; then
		cat >&2 <<-'EOF'

		切换目录失败...
		EOF
		exit 1
	fi

	kcptun_file_name="kcptun-${kcptun_release_tag_name}.tar.gz"
	if [ -f "$kcptun_file_name" ] && tar -tf "$kcptun_file_name" &>/dev/null; then
		cat >&2 <<-'EOF'

		已找到 Kcptun 文件压缩包, 跳过下载...
		EOF
		return 0
	fi

	if ! wget -e use_proxy=yes -e https_proxy="$HTTP_PROXY" --no-check-certificate -c -t 3 -O "$kcptun_file_name" "$kcptun_release_download_url"; then
		cat >&2 <<-EOF

		下载 Kcptun 文件压缩包失败, 你可以尝试手动下载文件:
		1. 下载 ${kcptun_release_download_url}
		2. 将文件重命名为 ${kcptun_file_name}
		3. 重新运行脚本开始安装
		EOF
		exit 1
	fi

}

# 解压文件
unpack_file() {
	cat >&2 <<-'EOF'

	开始解压文件...
	EOF

	cd "$DOWNLOAD_DIR"
	[ -d "$KCPTUN_INSTALL_DIR" ] || mkdir -p "$KCPTUN_INSTALL_DIR"
	tar -zxf "$kcptun_file_name" -C "$KCPTUN_INSTALL_DIR"

	local kcptun_client_exec="$KCPTUN_INSTALL_DIR"/client_"$FILE_SUFFIX"
	if [ -f "$kcptun_client_exec" ]; then
		if ! chmod a+x "$kcptun_client_exec"; then
			cat >&2 <<-'EOF'

			无法设置执行权限...
			EOF
			exit_with_error
		fi
	else
		cat >&2 <<-'EOF'

		未在解压文件中找到 Kcptun 客户端端执行文件, 请重试!
		EOF
		exit 1
	fi
}

# 安装清理
install_cleanup() {
	cat >&2 <<-'EOF'

	正在清理无用文件...
	EOF
	cd "$KCPTUN_INSTALL_DIR"
	rm -f "$KCPTUN_INSTALL_DIR"/server_"$FILE_SUFFIX"
}

show_installed_version() {
	cat >&2 <<-EOF

	当前安装的 Kcptun 版本为: ${installed_kcptun_version}
	EOF
}

# 显示安装信息
show_installed_info() {
	show_installed_version

	cat >&2 <<-EOF

	Kcptun 安装目录: ${KCPTUN_INSTALL_DIR}
	EOF
}

install_kcptun() {
	permission_check
	get_kcptun_version_info
	download_file
	unpack_file
	install_cleanup
	get_installed_version
	show_installed_info
}

# 检查变量是否为数字
is_number() {
	expr $1 + 1 >/dev/null 2>&1
}

# 重新下载 kcptun
update_kcptun() {
	download_file
	unpack_file
	install_cleanup
	show_installed_version

	cat >&2 <<-EOF

	恭喜, Kcptun 服务端更新完毕!
	EOF
}


check_update() {
	permission_check
	cat >&2 <<-EOF

	检查更新, 正在开始操作...
	EOF

	local shell_path=$0
	[ -d "$KCPTUN_INSTALL_DIR" ] || mkdir -p "$KCPTUN_INSTALL_DIR"

	get_installed_version
	get_kcptun_version_info

	local cur_tag_name="$installed_kcptun_version"

	if [ -n "$cur_tag_name" ] && is_number $cur_tag_name && [ ${#cur_tag_name} -eq 8 ]; then
		cur_tag_name=v"$cur_tag_name"
	fi

	if [ -n "$kcptun_release_tag_name" -a "$kcptun_release_tag_name" != "$cur_tag_name" ]; then
		cat >&2 <<-EOF

		发现 Kcptun 新版本 ${kcptun_release_tag_name}
		$(echo -e "更新说明: \n${kcptun_release_name}")
		$([ "$kcptun_release_prerelease" = "true" ] && echo -e "\033[41;37m 注意: 该版本为预览版, 请谨慎更新 \033[0m")

		按任意键开始更新, 或者 Ctrl+C 取消
		EOF
		any_key_to_continue
		echo "正在自动更新 Kcptun..."
		update_kcptun
	else
		cat >&2 <<-'EOF'

		未发现 Kcptun 更新...
		EOF
	fi
}

check_update
cat >&2 <<-'EOF'

检查更新完毕...

运行 kcp.sh 来启动kcptun
EOF
