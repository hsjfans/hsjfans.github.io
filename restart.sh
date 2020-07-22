#!/bin/sh
port_command=`lsof -i:4000`
run_command=`bundle exec jekyll s --watch`
code=`echo ${port_command}|grep ruby|awk '{print $11}'`
if [ ${code}>0 ]
then 
    echo 'current port is % and start to kill it '${code}
    echo `kill -9 ${code}`    
fi

echo 'start restart serve'

${run_command}
