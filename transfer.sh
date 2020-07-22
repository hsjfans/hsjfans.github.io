#!/bin/sh


 transfer_file(){

   echo $1 $2
   file=${1}${2}
   # 获取title
   title_line=`head -2 ${file}|tail -1`
   l=`expr ${#title_line} - 9`
   title=`echo ${title_line: 8: $l}|sed 's/[ ][ ]*/-/g'`
   # 获取日期
   time=`head -3 ${file}|tail -1|awk -F' ' '{print $2}'`
   echo $title $time
   sed -i '' '1a\
      layout: post
          ' ${file}
   new_title=${time}"-"${title}".md"
   echo "copy" ${file} ${1}${new_title}
   cp ${file} ${1}${new_title}
   rm ${file}

}         

transfer(){
    
   file_path=${1}
   if [ -f "${file_path}" ]
   then
      name=`echo ${file_path}|awk -F"/" '{print $NF}'`
      l=`expr ${#file_path} - ${#name}`
      path=${file_path: 0: ${l}}
      transfer_file $path $name 
   else
      files=`ls ${file_path}`
      for f in $files
      do
          transfer_file ${file_path} ${f}
      done
   fi
}


transfer $1

