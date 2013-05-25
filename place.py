#!/usr/bin/env python
'''
This script places every dot file to their destination.
'''

DATE = "Saturday, May 25 2013"
AUTHOR = "Yagnesh Raghava Yakkala"
WEBSITE = "http://yagnesh.org"
LICENSE = "GPL v3 or later"

import os
import inspect
import re
import shutil

this_file_path = os.path.abspath(os.path.split(inspect.getfile(
    inspect.currentframe()))[0])
ignores = [".git", "README.org", ".gitignore"]


def find_attri(f):
    n = d = None
    with open(f) as fh:
        for line in fh:
            if re.match(r'.\+DEST=(.*)', line):
                d = re.sub(r'.\+DEST=(.*)', r'\1', line)
            if re.match(r'.\+FNAME=(.*)', line):
                n = re.sub(r'.\+FNAME=(.*)', r'\1', line)
            if d and n:
                break
    return [n, d]


def link_file(f, dest):
    try:
        if os.access(os.path.dirname(dest), os.W_OK):
            if  os.path.exists(dest) and not os.path.islink(dest):
                shutil.move(dest, dest + '.backup')
            else:
                os.unlink(dest)
        os.symlink(os.path.abspath(f), dest)
    except OSError:
        print('*FAILED*: %s => %s' % (f, dest))


def place_file(f):
    [fname, d] = find_attri(f)
    if fname and d:
        dest = os.path.expandvars(d.rstrip()+fname.rstrip())
        print('   %s => %s' % (f, dest))
        link_file(f, dest)
    else:
        print('*FAILED*: %s => ???' % f)


def main():
    os.chdir(this_file_path)
    reg = re.compile("|".join(map(re.escape, ignores)))

    for f in os.listdir(this_file_path):
        if f == os.path.split(__file__)[1] or reg.search(f):
            continue
        place_file(f)


if __name__ == '__main__':
    main()
