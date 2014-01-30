FlowPlotter
===========

Generates visualizations from the output of flow tools such as SiLK.

--Usage--

rwfilter [filter] | dataplotter.sh [charttype] [independent variable] [dependent variable]

Currently you must run a SiLK rwfilter command and pipe it to dataplotter.sh and specify various options as arguments.
The following chart types are currently functional

geomap
- independent variable = Must specify an rwstats compatible field for country type (scc or dcc).
- dependent variable = Must specify an rwstats compatible value (Records,Packets,Bytes). Currently sIP-Distinct,dIP-Distinct, and Distinct:[field] have not been tested.

linechart
- independent variable = Must specify a bin-size that the dependent variable will be calculated by. For example, if you want "Records per Minute", this variable will be 60.
- dependent variable = Must specify an rwcount compatible value (Records,Packets,Bytes).

treemap
- independent variable = Must specify an rwstats compatible field.
- dependent variable = Must specify an rwstats compatible value (Records,Packets,Bytes). Currently sIP-Distinct,dIP-Distinct, and Distinct:[field] have not been tested.

timeline
- independent variable = Must specify an rwcut compatible field.
- dependent variable = Must specify an rwcut compatible field.

piechart
- independent variable = Must specify an rwstats compatible field.
- dependent variable = Must specify an rwstats compatible value (Records,Packets,Bytes). Currently sIP-Distinct,dIP-Distinct, and Distinct:[field] have not been tested.

barchart
- independent variable = Must specify an rwstats compatible field.
- dependent variable = Must specify an rwstats compatible value (Records,Packets,Bytes). Currently sIP-Distinct,dIP-Distinct, and Distinct:[field] have not been tested.

columnchart
- independent variable = Must specify an rwstats compatible field.
- dependent variable = Must specify an rwstats compatible value (Records,Packets,Bytes). Currently sIP-Distinct,dIP-Distinct, and Distinct:[field] have not been tested.

