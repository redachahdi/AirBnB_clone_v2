#!/usr/bin/python3
'''Fabric script to generate a .tgz archive from the web_static folder'''

from datetime import datetime
from fabric.api import local

def do_pack():
    '''Creates a .tgz archive from the content of the web_static'''

    '''create the versions folder if it does not exist'''
    local ("mkdir -p versions")

    '''create the file and datetime'''
    date = datetime.now().strftime("%Y%M%D%H%M%S")
    file = "versions/web_static_{}.tgz".format(date)

    """create .tgz archive"""
    result = local("tar -czvf {} web_static".format(file))

    if result.succeeded:
        return file
    else:
        return None
