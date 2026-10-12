# -*- coding: utf-8 -*-
import os
import sys
import json
import re

desktop = os.path.expanduser(r'~\Desktop')
app_dir = None
for item in os.listdir(desktop):
    if 'โพนพิสัย' in item:
        app_dir = os.path.join(desktop, item)
        break

print(f"App dir: {app_dir}")
if app_dir:
    for f in os.listdir(app_dir):
        print(f"  {f}")
