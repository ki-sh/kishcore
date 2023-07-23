#!/bin/bash
# Utility functions

# deprecate these:
function join { local IFS="$1"; shift; echo "$*"; }
function join_by { local d=$1; shift; local f=$1; shift; datestr=$( printf %s "$f" "${@/#/$d}" ); }

# in favour of: examle:
# IFS='/'; read -ra sa <<< "$start_date"; IFS=' '
# sd="${sa[*]}" #array to space delim str
# sd=${sd//' '/''} #remove spaces

# echo's $1... $last:colorcode, then resets color to normal
# simple ver: last param: roygbiv ? mcw  l-lime, 
# advanced:  further chars could be BKUR U-Underline,R-reverse,B-blink,N-bright/n-normal 
# these can be in combinations eg: 
# consider making an alias if useful. but consider testing (function mocking)
# function ecol() {
# }



# kstate _init _increment _get _set  TODO: _clear (wipe file/S)
# handy for state sharing between shells/subshells

# strip hidden chars (like colors from string)
# eg ansi_filter "$(tput setaf 9)foobar$(tput sgr0)"
xansi_filter() {
    local string
    string=$1
    string_sed="$(sed -r "s/\x1B\[[0-9;]*[JKmsu]//g" <<<"${string}")"
    echo "$string_sed"
}


# JSON, JSONP : JSON super basic, flat structures only.
# using to serialise vars and return as json as workaround for 
# bash <v4 only can echo strings from functions
# a way to get more than one variable back from functions
# JSONP implementation requires node js

# flat stupidly simple json serialiser.
# params:  key value key value ...
# example:
# intitle='gotta get into it if you wanna get out of it'
# indatespec="20031231T2359/20040101T0000"
# my_json=$(JSON "title" "$intitle" "datespec" "$indatespec")
# echo "my_json: $my_json"
# title=$(JSONP "title" "$my_json")
# datespec=$(JSONP "datespec" "$my_json")
# echo "outtitle: $title, outdatespec: $datespec"
function JSON () {
  local i=0
  local res=''
  local params=("$@")
  
  while [ $i -lt $# ]
  do
    # echo $i "${params[$i]}" "${params[$i+1]}"  
    res+="\"${params[$i]}\":\"${params[$i+1]}\""  
    i=$(( $i + 2))
    [[ i -lt $#-1 ]] && res+=','
  done
 res="{$res}"
  echo "$res"
}

function JSONP () {
  IFS=' '  
  #  log_info "JSONP data: $2"
  res=$(node -pe "JSON.parse(process.argv[1]).$1" "$2")
  [[ $res != 'undefined' ]] && echo "$res"
}


# cmdurl
# takes succinct command line input
# and converts to url
# params:
# $1 domainname/path/s\?customquery=something&another=somethingelse
# $2... the search terms, no need to use quotes
# qkey usually q, search_query (eg youtube)
# globaly (yuk) , sets $url
function cmdurl () {

    # split $1 into domain+paths (\? delimiter) query after delimiter
    local dom_query=(`echo $1 | tr '\?' ' '`)
    # log_info 'dom_query' $dom_query
    if [[ ${#dom_query[@]} == 2 ]]; then
     local query=${dom_query[1]}
    fi
    # log_info "query $query"
   

    # split dom of dom_query into domain and trailing path/s
    local arr=(`echo ${dom_query[0]} | tr '/' ' '`)

    local domain=${arr[0]}

    unset arr[0]
    local paths=$(join '/' ${arr[@]})

    # default to .com if eg no .co.uk etc specified:
    if [[ ! $domain == *"."* ]]; then
    local domain="$domain.com"
    fi

    # default to https:// if protocol not specified:
    # todo: slash splitting above messing with this. account for ://
    if [[ ! $domain == *":"* ]]; then
    local domain="https://$domain"
    fi

    shift

    # echo "@"
    local joined=$(join '+' $@)
    local q=$joined
    # q=$(urlencode $joined)
    url="$domain/$paths?$qkey=$q&$query"
}

# TODO: not working - returning with echo fails when 3 functions involved
# return $1 right padded with zeros to total length $2
# eg 3 4 -> 3000
# optional $3 padding character. defaults to 0.
function pad(){
    local res=""
    padto=$(($2 - ${#1}))

    padchar='0' # deafult 

   if (( $# == 3 )); then
        # override default with last param
        padchar="${@: -1}"
    fi

    # echo $padto
    for (( i=1; i<=$padto; i++ )) do 
       res+=$padchar
    done
    echo $res
}

function lpad(){
    lres=$(pad "$1" "$2")
    lres+=$1
    echo "$lres"
}

function rpad(){
    padding=$(pad "$1" "$2")
    rres=$1
    rres+=$padding
    echo $rres
}


#  rpadding= rpad "x" "2"
#  echo 'rpadding' $rpadding

#  lpadding= lpad "x" "2"
#  echo 'lpadding' $lpadding


# function lpad(){
#     local res=""
#     padto=$(($2 - ${#1}))

#     padchar='0' # deafult 

#    if (( $# == 3 )); then
#         # override default with last param
#         padchar="${@: -1}"
#     fi

#     # echo $padto
#     for (( i=1; i<=$padto; i++ )) do 
#        res+=$padchar
#     done
#     echo "$res$1"
# }
# left then right pads in one go
#  chartopad lpadby rpadby optionalpadchar
function lrpad(){
    local res=""
    local padto=$(($2 - ${#1}))

    padchar='0' # deafult 

   if (( $# == 4 )); then
        # override default with last param
        padchar="${@: -1}"
    fi

    # echo $padto
    for (( i=1; i<=$padto; i++ )) do 
       res+=$padchar
    done
    res+="$1"
    # now right pad the left padded string

    padto=$(($3 - ${#res}))
    for (( i=1; i<=$padto; i++ )) do 
       res+=$padchar
    done
    result=$res
    # echo "$res"
}


function dateshim() {
  osinfo=$(uname '-s')
  if [[ "Darwin" == *"$osinfo"* ]]; then
  res=$(date "-v+$1"  +"%Y%m%dT%H%M")
  echo "$res"
  else 
  echo "TODO linux or other (date -d instead of -v for mac...)"
fi
}

# function rpad(){
#     local res=""
#     padto=$(($2 - ${#1}))

#     padchar='0' # deafult 

#    if (( $# == 3 )); then
#         # override default with last param
#         padchar="${@: -1}"
#     fi

#     # echo $padto
#     for (( i=1; i<=$padto; i++ )) do 
#        res+=$padchar
#     done
#     echo "$1$res"
# }



# function urlencode() {
#     # urlencode <string>
 
#     old_lc_collate=$LC_COLLATE
#     LC_COLLATE=C
 
#     local length="${#1}"
#     for (( i = 0; i < length; i++ )); do
#         local c="${1:$i:1}"
#         case $c in
#             [a-zA-Z0-9.~_-]) printf '%s' "$c" ;;
#             *) printf '%%%02X' "'$c" ;;
#         esac
#     done
 
#     LC_COLLATE=$old_lc_collate
# }