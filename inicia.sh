#!/usr/bin/env bash

jupyter notebook --NotebookApp.token=$JUPITER_TOKEN --ip=0.0.0.0 --no-browser --allow-root
