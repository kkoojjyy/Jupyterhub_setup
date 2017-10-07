mkdir -p /srv/nbgrader/exchange
chmod ugo+rw /srv/nbgrader/exchange

conda install -c conda-forge nbgrader


jupyter nbextension disable --sys-prefix create_assignment/main
jupyter nbextension disable --sys-prefix formgrader/main --section=tree
jupyter serverextension disable --sys-prefix nbgrader.server_extensions.formgrader