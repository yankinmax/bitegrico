# -*- coding: utf-8 -*-

import os
from configparser import ConfigParser

directory = os.path.dirname(os.path.abspath(__file__))

def config(filename=directory+'/database.conf', section='Shop'):    
    parser = ConfigParser()
    parser.read(filename)     
    db = {}   
    
    if parser.has_section(section):
        params = parser.items(section)
        for param in params:
            db[param[0]] = param[1]
    else:
        raise Exception('Section {0} not found in the {1} file'.format(section, filename))    
    return db