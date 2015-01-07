
#！/bin/sh

# Program to out put a system information page

declare -r TITLE="System Information Report For $HOSTNAME"
CURRENT_TIME=$(date +"%x %r %z")
TIME_STAMP="Generated $CURRENT_TIME, by $USER"

echo  "<HTML>
     <HEAD>
             <TITLE>$TITLE</TITLE>
     </HEAD>
       <BODY>
            <H1>$TITLE</H1>
           <P>$TIME_STAMP</P>
       </BODY>
</HTML>"
