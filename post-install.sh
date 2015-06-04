#!/bin/bash

INSTALL_DIR=$1
cd $INSTALL_DIR

# Backup default conf/html
mv conf conf.defaults
mv html html.defaults

# Setup mount point symlinks
ln -s $INSTALL_DIR/conf /conf
ln -s $INSTALL_DIR/logs /logs
ln -s $INSTALL_DIR/html /app

# TODO, this will not needed if the installer removes it.
rm $INSTALL_DIR/logs/NOTEMPTY
