# Atom Settings
apm list --installed --bare > atom/packages.list
cp ~/.atom/{config.cson,init.coffee,keymap.cson,snippets.cson,styles.less} atom

git add -A
git commit -m "Synced"
git push origin master
