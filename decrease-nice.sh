#!/bin/sh

# *************************************************************************
# * Copyright (C) 2014 Daniel Mueller (deso@posteo.net)                   *
# *                                                                       *
# * This program is free software: you can redistribute it and/or modify  *
# * it under the terms of the GNU General Public License as published by  *
# * the Free Software Foundation, either version 3 of the License, or     *
# * (at your option) any later version.                                   *
# *                                                                       *
# * This program is distributed in the hope that it will be useful,       *
# * but WITHOUT ANY WARRANTY; without even the implied warranty of        *
# * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
# * GNU General Public License for more details.                          *
# *                                                                       *
# * You should have received a copy of the GNU General Public License     *
# * along with this program.  If not, see <http://www.gnu.org/licenses/>. *
# *************************************************************************

if [ $# != 1 ]
then
  echo "Invalid parameter count."
  echo "Usage: $0 <process pattern>"
  exit 1
fi

pids=$(ps -A | grep "$1" | awk '{print $1}')

if [ -n "${pids}" ]
then
  echo "${pids}" | xargs -L 1 --replace='{}' ionice --class=idle --pid={}
  echo "${pids}" | xargs renice -n 20
fi
