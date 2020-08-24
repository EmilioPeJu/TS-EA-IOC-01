cat <<EOF >> $1/${2}App/opi/edl/${2}Top.edl

# (Shell Command)
object shellCmdClass
beginObjectProperties
major 4
minor 3
release 0
x 315
y 310
w 90
h 20
fgColor index 14
bgColor index 3
topShadowColor index 1
botShadowColor index 11
font "arial-bold-r-14.0"
buttonLabel "Start IOC"
numCmds 1
command {
  0 "gnome-terminal -- \$(configure-ioc s -p ${2}) 6064"
}
endObjectProperties

# (Shell Command)
object shellCmdClass
beginObjectProperties
major 4
minor 3
release 0
x 315
y 340
w 90
h 20
fgColor index 14
bgColor index 3
topShadowColor index 1
botShadowColor index 11
font "arial-bold-r-12.0"
buttonLabel "Start Malcolm"
numCmds 1
command {
  0 "gnome-terminal -- \$(configure-ioc s -p ${2/EA-IOC/ML-MALC})"
}
endObjectProperties
EOF

sed -e '7i export hostname=$(hostname -s)\' \
    -i $1/iocBoot/ioc${2}/st${2}.sh
sed -e "s/.*.db'/&, hostname=\$(hostname)/" \
    -i $1/iocBoot/ioc${2}/st${2}.src
sed -e "s/${2}Top.edl/-m hostname=\$(hostname -s) ${2}Top.edl/" \
    -e '2i export EPICS_CA_SERVER_PORT=6064' \
    -e '3i export EPICS_CA_REPEATER_PORT=6065' \
    -i $1/${2}App/opi/edl/st${2}-gui

