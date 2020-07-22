#!/bin/sh

layer="post"

function transfer_file(file_path,file_name){
  
   file=file_path"/"file_name
   # 获取title
   title=`head -3 ${file}|tail -1`
   # 获取日期
   time=`head -4 ${file}|tail -1`
   sed -e 1a\${layer} ${file}
   new_title=${time: 0: 11}"/"${title}".md"
   mv ${file} ${da}

}         

function transfer(file_path){
   
   if [ -f "${file_path}" ]
   then
      path=`echo ${file_path}|awk -F"/" '{print ${NF-1}'`
      name=`echo ${file_path}|awk -F"/" '{print $NF}'`
      transfer_file $path $name 
   else
      files=${ls ${file_path}}
      for f in $files
      do
          transfer ${file_path} ${f}
      done
   fi
}


transfer $1

