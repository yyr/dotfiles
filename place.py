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
import logging


def _get_logger():
    LOG_FORMAT = '%(levelname)-6s: %(message)s'
    logger = logging.getLogger('wrfout')
    logger.setLevel(logging.INFO)
    if not logger.handlers:
        hlr = logging.StreamHandler()
        hlr.setFormatter(logging.Formatter(LOG_FORMAT))
        logger.addHandler(hlr)
    return logger


this_file_path = os.path.abspath(os.path.split(inspect.getfile(
    inspect.currentframe()))[0])
ignores = [".git", "README.org", ".gitignore"]
lgr = _get_logger()


def find_attri(f):
    n = d = None
    with open(f) as fh:
        for line in fh:
            if re.match(r'.*\+DEST=(.*)', line):
                d = re.sub(r'.*\+DEST=(.*)', r'\1', line)
            elif re.match(r'.*\+FNAME=(.*)', line):
                n = re.sub(r'.*\+FNAME=(.*)', r'\1', line)
            elif d and n:
                break
    return [n, d]


def link_file(f, dest):
    """
    Check if the destination is writable or not. Backup if there is already a
    destination file(don't bother about links) exists.

    Finally link `f` to `dest`.
    """
    dest_dir = os.path.dirname(dest)
    if not os.path.exists(dest_dir) or not os.access(
            os.path.dirname(dest), os.W_OK):
        lgr.error('Destination "%s" doesn\'t exits or not writable' % dest_dir)
        return False
    else:
        if os.path.exists(dest):
            if not os.path.islink(dest):
                lgr.info('Backing up original to %s' % dest + '.orig')
                shutil.move(dest, dest + '.orig')

            try:
                os.unlink(dest)
            except OSError:
                lgr.error('*FAILED*: deleting %s' % dest)
        try:
            return os.symlink(os.path.abspath(f), dest)
        except OSError:
            lgr.error('*FAILED*: linking %s => %s' % (f, dest))


def place_file(f):
    [fname, d] = find_attri(f)
    if fname and d:
        dest = os.path.expandvars(d.rstrip()+fname.rstrip())
        lgr.info('Placing %s => %s' % (f, dest))
        return link_file(f, dest)
    else:
        lgr.error('*FAILED*: %s => ???' % f)


def main():
    os.chdir(this_file_path)
    reg = re.compile("|".join(map(re.escape, ignores)))

    for f in os.listdir(this_file_path):
        if f == os.path.split(__file__)[1] or reg.search(f):
            continue
        place_file(f)


if __name__ == '__main__':
    main()
