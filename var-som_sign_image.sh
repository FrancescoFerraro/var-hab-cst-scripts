#! /bin/bash

usage()
{
	echo "Usage: SOC=<soc> `basename "$0"` IMGFILE [IMGEFILE]..."
	echo "soc is one of {mx6, mx6ul, mx6ull, mx7}"
	echo "LOADADDR is optional; if omitted, a SoC-specific default is used"
	echo "Note: for U-Boot/SPL images, make sure their log file is present in the same directory"
	echo
}

DEFAULT_LOADADDR_MX6=0x12000000
DEFAULT_LOADADDR_MX6UL=0x82000000
DEFAULT_LOADADDR_MX6ULL=0x82000000
DEFAULT_LOADADDR_MX7=0x80800000


if [ "$#" -eq 0 ]; then
	usage
	exit 1
fi


if [ "$SOC" == "mx6" ]; then
	DEFAULT_LOADADDR=$DEFAULT_LOADADDR_MX6
elif [ "$SOC" == "mx6ul" ]; then
	DEFAULT_LOADADDR=$DEFAULT_LOADADDR_MX6UL
elif [ "$SOC" == "mx6ull" ]; then
	DEFAULT_LOADADDR=$DEFAULT_LOADADDR_MX6ULL
	export ENGINE=SW
elif [ "$SOC" == "mx7" ]; then
	DEFAULT_LOADADDR=$DEFAULT_LOADADDR_MX7
else
	usage
	exit 1
fi

export LOADADDR=${LOADADDR:-$DEFAULT_LOADADDR}


./var-sign_image.sh $@
