#!/usr/bin/python
import glob
import os
current_dir = os.path.abspath(os.path.dirname(__file__))
j = lambda *args: os.path.join(current_dir, *args)

jobs = [(j("vim"), "~/.vim"), (j("vimrc"), "~/.vimrc")]

for path, target in jobs:
    target = os.path.expanduser(target)
    if os.path.lexists(target):
        print target, "already exists"
    else:
        os.symlink(path, target)
        print "created", target



