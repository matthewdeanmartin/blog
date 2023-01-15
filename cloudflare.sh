echo "Gather Info"
which python
python --version
echo
which pip
pip --version
pip freeze
echo
pip install pipenv
which pipenv
echo
echo "Activate"
echo
source /opt/buildhome/repo/.venv/bin/activate
echo
echo "Did we activate?"
echo
pip --version
pip freeze
echo
echo "Summon the pelican!!!"
echo
/opt/buildhome/repo/.venv/bin/pelican --version
/opt/buildhome/repo/.venv/bin/pelican content -s pelicanconf.py -t themes/pelican-hyde
