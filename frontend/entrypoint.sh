#!/bin/bash

export REACT_APP_POD=$HOSTNAME

npm run build && serve -s build/