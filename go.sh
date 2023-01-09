export THEME=themes/pelican-hyde
pipenv run pelican content -s pelicanconf.py -t $THEME
start output/index.html
