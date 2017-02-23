#!/bin/sh
echo "------------------------------------------------------------"
echo "Adjust studio.vmoptions"
echo "------------------------------------------------------------"
curl https://raw.githubusercontent.com/deskid/dotfiles/master/studio.vmoptions -o /Applications/Android\ Studio.app/Contents/bin/studio.vmoptions
tail -n 5 /Applications/Android\ Studio.app/Contents/bin/studio.vmoptions
echo "\n------------------------------------------------------------"
echo "\n\n"


as_gradle_version=$(ls /Applications/Android\ Studio.app/Contents/gradle/ | grep gradle)

echo "------------------------------------------------------------"
echo "Adding android $as_gradle_version to path"
echo "------------------------------------------------------------"
echo 'export PATH=${PATH}:/Applications/Android\ Studio.app/Contents/gradle/'"$as_gradle_version"'/bin'  >> ~/.zshrc
tail -n 1 ~/.zshrc
gradle -v
echo "------------------------------------------------------------"

echo "\n\n"

echo "done"