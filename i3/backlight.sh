#!/bin/bash
echo $(xbacklight -get | cut -d'.' -f1)%

