#!/usr/bin/python  
#-*-coding:UTF-8 -*-  
import sys
rack = {"hadoop":"rack-1",
"hadoop1":"rack-1",
"hadoop2":"rack-1",
"192.168.0.3":"rack-1",
"192.168.0.10":"rack-1",
"192.168.0.11":"rack-1"}
if __name__=="__main__":  
	print "/" + rack.get(sys.argv[1],"rack-default")
