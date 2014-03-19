#!/bin/bash

#FlowPlotter is a script that allows for the "easy" integration of SiLK results into various Google Visualization Chart APIs.

#GEOMAPGEOMAPGEOMAPGEOMAPGEOMAPGEOMAPGEOMAPGEOMAPGEOMAPGEOMAPGEOMAPGEOMAPGEOMAPGEOMAPGEOMAPGEOMAP
geomap () {
#Variable Creation
#independent variable is a string
#value is a string
title="$1 by $2"
independent="$1"
value="$2"
graphtitle="$independent by $value"
######################
rwstats --top --count=275 --fields=$independent --value=$value --delimited=, |\
 grep ","| grep -v -- "--"| grep -v "a1" | grep -v "us"| cut -d "," -f1,2 |\
 sed "1 s/\([A-Za-z]\{1,20\}\),\([A-Za-z]\{1,20\}\)/['\1', '\2'],/g"|sed "s/\([a-z]\{2\}\),\([0-9]\{1,50\}\)/['\1', \2],/g"|sed '$s/,$//' > temp.test

sed '/dataplaceholder/{
    s/dataplaceholder//g
    r temp.test
}' googlechart/geomap.html
rm temp.test
}
#GEOMAPGEOMAPGEOMAPGEOMAPGEOMAPGEOMAPGEOMAPGEOMAPGEOMAPGEOMAPGEOMAPGEOMAPGEOMAPGEOMAPGEOMAPGEOMAP



#linechartlinechartlinechartlinechartlinechartlinechartlinechartlinechartlinechartlinechartlinechart
linechart () {
#Variable Creation
#independent variable is a string
#value is an string
title="$1 by $2"
resolution="$1"
value="3"
if [ "$2" = "records" ]; then
value="2"
valuename="records"
fi
if [ "$2" = "bytes" ]; then
value="3"
valuename="Bytes"
fi
if [ "$2" = "packets" ]; then
value="4"
valuename="Packets"
fi
if [ -z "$valuename" ]; then
value="3"
valuename="Bytes"
fi
if [ -z "$resolution" ]; then
resolution="60"
fi
graphtitle="$valuename per $resolution second bins"

##########################
rwcount --bin-size=$resolution --delimited=, | cut -d "," -f1,$value|\
sed "s/\(.*\),\(.*\)/['\1', \2],/g"|sed '$s/,$//'| sed "s/, \([A-Za-z].*\)],/, '\1'],/g" > temp.test

sed '/dataplaceholder/{
    s/dataplaceholder//g
    r temp.test
}' googlechart/linechart.html | sed "s/titleplaceholder/${graphtitle}/g"

rm temp.test
}
#linechartlinechartlinechartlinechartlinechartlinechartlinechartlinechartlinechartlinechartlinechart



#treemaptreemaptreemaptreemaptreemaptreemaptreemaptreemaptreemaptreemaptreemaptreemaptreemaptreemap
treemap () {
#Variable Creation
#independent variable is a string
#value is a string
title="$1 by $2"
independent="$1"
value="$2"
graphtitle="$independent by $value"
#####################
echo "['$independent', 'parent', '$value']," > temp.test
echo "['$independent', null, 0]," >> temp.test
rwstats --fields=$independent --top --count=20  --no-titles --delimited=, --value=$value |\
cut -d "," -f1,2 |\
grep ,| sed "s/\(.*\),\(.*\)/['\1', '$independent', \2],/g"|sed '$s/,$//'| sed "s/, \([A-Za-z].*\)],/, '\1'],/g" | grep "," >> temp.test

sed '/dataplaceholder/{
    s/dataplaceholder//g
    r temp.test
}' googlechart/treemap.html | sed "s/titleplaceholder/${graphtitle}/g"

rm temp.test
}
#treemaptreemaptreemaptreemaptreemaptreemaptreemaptreemaptreemaptreemaptreemaptreemaptreemaptreemap


#timelinetimelinetimelinetimelinetimelinetimelinetimelinetimelinetimelinetimelinetimeline
timeline () {
#Variable Creation
#independent variable is a string
#dependent variable is a string
title='Suspicious Server Traffic'
title="$1 by $2"
independent="$1"
dependent="$2"
if [ -z "${independent}" ]; then
independent="sip"
fi
if [ -z "${dependent}" ]; then 
dependent="dip"
fi
graphtitle="$independent by $dependent over time"
##############################
rwsort --fields=stime | rwgroup --delta-field=stime --delta-value=2 --summarize | rwsort --fields=sip | rwcut --fields=$independent,$dependent,stime,etime --delimited=, --no-titles |\
sed "s/\(.*\),\(.*\),\(.*\),\(.*\)/['\1', '\2', new Date(\3), new Date (\4)],/g"|sed '$s/,$//'| \
sed "s/\([0-9]\{4\}\)\/\([0-9]\{2\}\)\/\([0-9]\{2\}\)T\([0-9]\{2\}\):\([0-9]\{2\}\):\([0-9]\{2\}\)\.[0-9]\{3\}/\1, \2, \3, \4, \5, \6/g" > temp.test

sed '/dataplaceholder/{
    s/dataplaceholder//g
    r temp.test
}' googlechart/timeline.html | sed "s/titleplaceholder/${graphtitle}/g"

rm temp.test
}
#timelinetimelinetimelinetimelinetimelinetimelinetimelinetimelinetimelinetimelinetimeline


#piechartpiechartpiechartpiechartpiechartpiechartpiechartpiechartpiechartpiechartpiechartpiechartpiechartpiechart
piechart () {
#Variable Creation
#independent variable is a string
#value is a string
title="$1 by $2"
independent="$1"
value="$2"
graphtitle="$independent by $value"
#####################
echo "['$independent', '$value']," > temp.test
rwstats --fields=$independent --top --count=12  --no-titles --delimited=, --value=$value |\
cut -d "," -f1,2 |\
grep ,| sed "s/\(.*\),\(.*\)/['\1', \2],/g"|sed '$s/,$//'| sed "s/, \([A-Za-z].*\)],/, '\1'],/g" | grep "," >> temp.test

sed '/dataplaceholder/{
    s/dataplaceholder//g
    r temp.test
}' googlechart/piechart.html | sed "s/titleplaceholder/${graphtitle}/g"

rm temp.test
}
#piechartpiechartpiechartpiechartpiechartpiechartpiechartpiechartpiechartpiechartpiechartpiechartpiechartpiechart


#barchartbarchartbarchartbarchartbarchartbarchartbarchartbarchartbarchartbarchartbarchartbarchartbarchartbarchart
barchart () {
#Variable Creation
#independent variable is a string
#value is an string
title="$1 by $2"
independent="$1"
value="$2"
graphtitle="$independent by $value"
#####################
echo "['$independent', '$value']," > temp.test
rwstats --fields=$independent --top --count=12  --no-titles --delimited=, --value=$value |\
cut -d "," -f1,2 |\
grep ,| sed "s/\(.*\),\(.*\)/['\1', \2],/g"|sed '$s/,$//'| sed "s/, \([A-Za-z].*\)],/, '\1'],/g" | grep "," >> temp.test

sed '/dataplaceholder/{
    s/dataplaceholder//g
    r temp.test
}' googlechart/barchart.html | sed "s/titleplaceholder/${graphtitle}/g"

rm temp.test
}
#barchartbarchartbarchartbarchartbarchartbarchartbarchartbarchartbarchartbarchartbarchartbarchartbarchartbarchart


#columnchartcolumnchartcolumnchartcolumnchartcolumnchartcolumnchartcolumnchartcolumnchartcolumnchartcolumnchartcolumnchartcolumnchartcolumnchartcolumnchart
columnchart () {
#Variable Creation
#independent variable is a string
#value is an string
title="$1 by $2"
independent="$1"
value="$2"
graphtitle="$independent by $value"
#####################
echo "['$independent', '$value']," > temp.test
rwstats --fields=$independent --top --count=12  --no-titles --delimited=, --value=$value |\
cut -d "," -f1,2 |\
grep ,| sed "s/\(.*\),\(.*\)/['\1', \2],/g"|sed '$s/,$//'| sed "s/, \([A-Za-z].*\)],/, '\1'],/g" | grep "," >> temp.test

sed '/dataplaceholder/{
    s/dataplaceholder//g
    r temp.test
}' googlechart/columnchart.html | sed "s/titleplaceholder/${graphtitle}/g"

rm temp.test
}
#columnchartcolumnchartcolumnchartcolumnchartcolumnchartcolumnchartcolumnchartcolumnchartcolumnchartcolumnchartcolumnchartcolumnchartcolumnchartcolumnchart



#tablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablechart
tablechart () {
#echo "['sTime', 'sIP', 'sPort', 'scc', 'dIP', 'dPort', 'dcc', 'protocol', 'initialFlags', 'flags', 'type', 'sensor', 'eTime']," > temp.test
rwcut --fields=stime,sip,sport,scc,dip,dport,dcc,pro,initialF,flags,type,sen,etime --delimited=, --no-titles| head -1000 |\
 perl -p -i -e "s/(.*?)\,(.*?)\,(.*?)\,(.*?)\,(.*?)\,(.*?)\,(.*?)\,(.*?)\,(.*?)\,(.*?)\,(.*?)\,(.*?)\,(.*?)$/['\$1', '\$2', '\$3', '\$4', '\$5', '\$6', \$7, '\$8', '\$9', '\$10', '\$11', '\$12', '\$13'],/" |\
 sed 's/\-\-//g'| sed '$s/,$//' >>temp.test
 
 sed '/dataplaceholder/{
    s/dataplaceholder//g
    r temp.test
}' googlechart/tablechart.html | sed "s/titleplaceholder/${graphtitle}/g"

rm temp.test
}
#tablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablecharttablechart



#bubblechartbubblechartbubblechartbubblechartbubblechartbubblechartbubblechartbubblechartbubblechartbubblechartbubblechartbubblechartbubblechartbubblechart
bubblechart () {
#Variable Creation
#independent variable is a string
#value is an string
title="$1 by $2"
independent="$1"
graphtitle="Byte:Packet:Record for top 20 $independent"
#####################
#echo "['$independent', '$value']," > temp.test

rwstats --fields=$independent --value=bytes,records,packets --count=20 --delimited=" " | awk '{print $1,$4,$2,$1,$3}'| grep -v ":"|sed 's/ /,/g' |\
sed "s/\([a-zA-Z]\{1,20\}\),\([a-zA-Z]\{1,20\}\),\([a-zA-Z]\{1,20\}\),\([a-zA-Z]\{1,20\}\),\([a-zA-Z]\{1,20\}\)/['\1', '\2', '\3', '\4', '\5'],/g" |\
sed "s/\(.\{1,20\}\),\([0-9]\{1,20\}\),\([0-9]\{1,20\}\),\(.\{1,20\}\),\(.\{1,20\}\)/['\1', \2, \3, '\4', \5],/g" | sed '$s/,$//' >> temp.test

sed '/dataplaceholder/{
    s/dataplaceholder//g
    r temp.test
}' googlechart/bubblechart.html | sed "s/titleplaceholder/${graphtitle}/g"

rm temp.test
}
#bubblechartbubblechartbubblechartbubblechartbubblechartbubblechartbubblechartbubblechartbubblechartbubblechartbubblechartbubblechartbubblechartbubblechart



#Function Initiation

if [ "$1" == "-h" ]; then
  cat README.md
  echo -e "\n"
  exit 0
fi

if [ "$1" != "geomap" -a "$1" != "linechart"  -a "$1" != "treemap"  -a "$1" != "timeline"  -a "$1" != "piechart"  -a "$1" != "barchart"  -a "$1" != "columnchart" -a "$1" != "bubblechart" ]; then
echo ""
echo "ERROR: You must specify a support chart type. "
echo ""
echo "The only supported chart types for flowplotter are:"
echo "./flowplotter geomap [independepent] [dependent]"
echo "./flowplotter linechart [independepent] [dependent]"
echo "./flowplotter treemap [independepent] [dependent]"
echo "./flowplotter timeline [independepent] [dependent]"
echo "./flowplotter piechart [independepent] [dependent]"
echo "./flowplotter barchart [independepent] [dependent]"
echo "./flowplotter columnchart [independepent] [dependent]"
echo "./flowplotter bubblechart [independepent]"
echo ""
echo "flowplotter --help"
echo "./flowplotter -h"
echo ""
exit 0
fi

if [ "$1" = "geomap" ]; then
geomap $2 $3
fi
if [ "$1" = "linechart" ]; then
linechart $2 $3
fi
if [ "$1" = "treemap" ]; then
treemap $2 $3
fi
if [ "$1" = "timeline" ]; then
timeline $2 $3
fi
if [ "$1" = "piechart" ]; then
piechart $2 $3
fi
if [ "$1" = "barchart" ]; then
barchart $2 $3
fi
if [ "$1" = "columnchart" ]; then
columnchart $2 $3
fi
if [ "$1" = "bubblechart" ]; then
bubblechart $2
fi
#if [ "$1" = "tablechart" ]; then
#tablechart $2
#fi
