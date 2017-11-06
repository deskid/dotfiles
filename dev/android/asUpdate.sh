#!/bin/zsh
ANDROID_STUDIO_PREFERENCES_PATH=`find ${HOME}/Library/Preferences -name 'AndroidStudio*' -depth 1 | sort -r | head -1`
VMOPTIONS_PATH="${ANDROID_STUDIO_PREFERENCES_PATH}/studio.vmoptions"

echo "------------------------------------------------------------"
echo "Adjust studio.vmoptions"
echo "------------------------------------------------------------"
curl https://raw.githubusercontent.com/deskid/dotfiles/master/dev/android/studio.vmoptions -o $VMOPTIONS_PATH
tail -n 5 $VMOPTIONS_PATH
echo "\n------------------------------------------------------------"
echo "\n\n"


as_gradle_version=$(ls /Applications/Android\ Studio.app/Contents/gradle/ | grep gradle)

echo "------------------------------------------------------------"
echo "Adding android $as_gradle_version to path"
echo "------------------------------------------------------------"
echo 'export PATH=${PATH}:/Applications/Android\ Studio.app/Contents/gradle/'"$as_gradle_version"'/bin'  >> ~/.zshrc
tail -n 1 ~/.zshrc

source ~/.zshrc
chmod a+x /Applications/Android\ Studio.app/Contents/gradle/"$as_gradle_version"/bin/gradle
gradle -v
echo "------------------------------------------------------------"
echo "\n\n"

echo "------------------------------------------------------------"
echo "Remove author from new files AS template"
echo "------------------------------------------------------------"

FILE_HEADER_PATH="${ANDROID_STUDIO_PREFERENCES_PATH}/fileTemplates/includes/File Header.java"
if [ -f "$FILE_HEADER_PATH" ]; then
	cat /dev/null > $FILE_HEADER_PATH
fi

echo "done"
