echo Delete old files...
rm ./category/ -rf
rm ./tag/ -rf
rm ./author/ -rf

echo Copying new files...
cp jekyllbuild/category/ . -r
cp jekyllbuild/tag/ . -r
cp jekyllbuild/author/ . -r

echo Done!
