#!/bin/bash
LOCAL=$(pwd)
BIN=/usr/local/bin

echo "Setup: php7"
chmod +x ${LOCAL}/php
ln -s ${LOCAL}/php ${BIN}/php

echo "Setup: php56"
chmod +x ${LOCAL}/php56
ln -s ${LOCAL}/php56 ${BIN}/php56

echo "Setup: composer"
chmod +x ${LOCAL}/composer
ln -s ${LOCAL}/composer ${BIN}/composer

echo "Setup: composer"
chmod +x ${LOCAL}/composer56
ln -s ${LOCAL}/composer56 ${BIN}/composer56

echo "Setup: nodejs"
chmod +x ${LOCAL}/nodejs
ln -s ${LOCAL}/nodejs ${BIN}/nodejs

