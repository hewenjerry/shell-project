sh /data/script/web-build-mis-online.sh hehua-mis

if [ $# -ge 1 ]; then
        USER=hhdev
        HOST=bjweb1
        rsync -ztrlvC --delete /data/build/hehua-mis/ $USER@$HOST:/data/webapps/hehua-mis/
        ssh $USER@$HOST "/opt/jetty-mis/bin/jetty.sh restart"
else
        rsync -ztrlvC --delete /data/build/hehua-mis/ /data/webapps/hehua-mis/
        /opt/jetty-mis/bin/jetty.sh restart
fi
