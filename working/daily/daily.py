# coding=utf-8
import os
import subprocess
from datetime import date

from jinja2 import Template

DATE = str(date.today())
FILE_NAME = DATE + '.md'
ROOT_PATH = os.path.abspath(os.path.join(os.path.abspath(__file__), os.pardir))
WRITE_PATH = os.path.join('~/Dropbox/notes/日报', FILE_NAME)


def notify(title, info_text):
    title = title.replace('"', '\'')
    info_text = info_text.replace('"', '\'')
    cmd = """osascript -e 'display notification  "%s"  with title "%s" sound name "Funk.aiff"'""" % (
        info_text, title)
    subprocess.call(cmd, shell=True)


def render():
    template_path = os.path.join(ROOT_PATH, 'template', 'DailyReport.md')
    with open(template_path, 'r') as report_template:
        content = report_template.read().decode('utf-8')
        template = Template(content)
        result = template.render()

        with open(WRITE_PATH, 'w') as log_file:
            log_file.write(result.encode('utf-8'))
            log_file.flush()


render()
notify('日报已生成,开始工作吧', FILE_NAME)
print '日报已生成'
