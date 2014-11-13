#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sqlite3

cx = sqlite3.connect("corpus.db")
cur = cx.cursor()
cur.execute('CREATE TABLE corpus(\
    id INTEGER PRIMARY KEY AUTOINCREMENT,\
    doc_index INTEGER UNIQUE,\
    doc_id CHAR(512) UNIQUE,\
    doc_content TEXT\
)')
cx.commit()

textReader = open("corpus.txt","r")
file_line = textReader.readlines()
counter = 0
for line in file_line:
    counter +=1
    cur.execute('INSERT INTO corpus(doc_index, doc_id, doc_content) VALUES ("%s","%s","%s")' %(counter,counter,line))
    cx.commit()

cur.close()
cx.close()

    
    
