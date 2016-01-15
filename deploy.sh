echo $1 > version
git add .
git commit -am $1
eb deploy
