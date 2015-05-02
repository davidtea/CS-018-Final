#!/bin/bash
# put source code file as first parameter
# will show only matches to regex expression.
egrep -o '("https?:\/\/\S+w")|("https?:\/\/\S+(\.\w\w\w")[^,])|("\/?[^"]\/\S+[0-9]"[^,])|("https?:\/\/\S*"?[^,])|("https?:\/\/\S+\"?[^,])|("\/\S*\.\w\w\w"[^,])' $1
