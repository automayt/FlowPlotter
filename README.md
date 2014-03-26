FlowPlotter
===========
Jason Smith
To-Do list - https://gist.github.com/automayt/66334c9da768fa9190d8
===========

Generates visualizations from the output of flow tools such as SiLK.

--Prerequisites--

Installed SiLK tools with access to a SiLK data set (https://tools.netsa.cert.org/silk/).

--Usage--

rwfilter [filter] | flowplotter.sh [charttype] [independent variable] [dependent variable]

Currently you must run a SiLK rwfilter command and pipe it to flowplotter.sh and specify various options as arguments.
The following chart types are currently functional

geomap
- independent variable = Must specify an rwstats compatible field for country type (scc or dcc).
- dependent variable = Must specify an rwstats compatible value (Records, Packets, Bytes, sIP-Distinct, dIP-Distinct, or Distinct:[field])

linechart
- independent variable = Must specify a bin-size that the dependent variable will be calculated by. For example, if you want "Records per Minute", this variable will be 60.
- dependent variable = Must specify an rwcount compatible value (Records,Packets,Bytes).

treemap
- independent variable = Must specify an rwstats compatible field.
- dependent variable = Must specify an rwstats compatible value (Records, Packets, Bytes, sIP-Distinct, dIP-Distinct, or Distinct:[field])

timeline
- independent variable = Must specify an rwcut compatible field.
- dependent variable = Must specify an rwcut compatible field.

piechart
- independent variable = Must specify an rwstats compatible field.
- dependent variable = Must specify an rwstats compatible value (Records, Packets, Bytes, sIP-Distinct, dIP-Distinct, or Distinct:[field])

barchart
- independent variable = Must specify an rwstats compatible field.
- dependent variable = Must specify an rwstats compatible value (Records, Packets, Bytes, sIP-Distinct, dIP-Distinct, or Distinct:[field])

columnchart
- independent variable = Must specify an rwstats compatible field.
- dependent variable = Must specify an rwstats compatible value (Records, Packets, Bytes, sIP-Distinct, dIP-Distinct, or Distinct:[field])

bubblechart
- Displays a bytes:packets:records ratio bubblechart for the top 20 [independent variable] for a given filter.
- independent variable = Must specify an rwstats compatible field.


--Examples--

Generate a geomap of bytes to from all traffic to destination country codes - 
rwfilter --start-date=2013/12/27 --proto=0- --type=all --pass=stdout | ./flowplotter.sh geomap dcc bytes > geomap.html

Generate a linechart for all outbound webtraffic displaying the amount of bytes per 60 second bins - 
rwfilter --start-date=2013/12/27 --proto=0- --type=all --pass=stdout | ./flowplotter.sh linechart 60 bytes > linechart.html

Generate a treemap that shows the destination IP addresses (NOT in the 192.168.1.0/24 range) that exhibited the most records consisting of highport-highport communications - 
rwfilter --start-date=2013/12/27 --sport=1025- --dport=1025- --not-daddress=192.168.1.0/24 --proto=0- --type=all --pass=stdout | ./flowplotter.sh treemap dip records > treemap.html

Generate a timeline showing devices communicating with non-local and non-US hosts
rwfilter --start-date=2013/12/27 --proto=0- --type=out,outweb --dcc=us,-- --fail=stdout | ./flowplotter.sh timeline sip dip > timeline.html

Generate a piechart that shows the destination IP addresses (NOT in the 192.168.1.0/24 range) that exhibited the most records consisting of highport-highport communications -
rwfilter --start-date=2013/12/27 --sport=1025- --dport=1025- --not-daddress=192.168.1.0/24 --proto=0- --type=all --pass=stdout | ./flowplotter.sh piechart dip bytes > piechart.html

Generate a barchart that shows the destination IP addresses (NOT in the 192.168.1.0/24 range) that exhibited the most records consisting of highport-highport communications -
rwfilter --start-date=2013/12/27 --sport=1025- --dport=1025- --not-daddress=192.168.1.0/24 --proto=0- --type=all --pass=stdout | ./flowplotter.sh barchart dip bytes > barchart.html

Generate a columnchart that shows the destination IP addresses (NOT in the 192.168.1.0/24 range) that exhibited the most records consisting of highport-highport communications -
rwfilter --start-date=2013/12/27 --sport=1025- --dport=1025- --not-daddress=192.168.1.0/24 --proto=0- --type=all --pass=stdout | ./flowplotter.sh columnchart dip bytes > columnchart.html

Generate a bubblechart that shows the the top 20 destination country codes sorted by a bytes:records:packet ratio - 
rwfilter --start=2014/02/01 --end-date=2014/02/05  --proto=0- --type=all --pass=stdout | ./flowplotter.sh bubblechart dcc > test.html

Generate a force-directed graph showing two way relationships between IP addresses from rwstats, showing the top 100 sip,dip pairs sorted by the highest distinct dport numbers to each. Open d3chart/forceopacity.html in Firefox.
rwfilter --start-date=2014/02/06 --proto=0- --type=all --pass=stdout | ./flowplotter.sh forceopacity sip dip distinct:dport 100
