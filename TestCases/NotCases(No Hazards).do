project compileall
vsim work.processor(nohazards)
mem load -skip 0 -filltype value -filldata { 1111111100000000} -fillradix symbolic /processor/Fetcher/memory

mem load -filltype value -filldata { 1111000000000000 } -fillradix symbolic /processor/Fetcher/memory(0)
mem load -filltype value -filldata { 1111000010000000 } -fillradix symbolic /processor/Fetcher/memory(1)
mem load -filltype value -filldata { 1111000100000000 } -fillradix symbolic /processor/Fetcher/memory(2)
mem load -filltype value -filldata { 1111000110000000 } -fillradix symbolic /processor/Fetcher/memory(3)
mem load -filltype value -filldata { 1111001000000000 } -fillradix symbolic /processor/Fetcher/memory(4)
mem load -filltype value -filldata { 1111001010000000 } -fillradix symbolic /processor/Fetcher/memory(5)


mem load -filltype value -filldata 10 -fillradix decimal /processor/Handler/R(5)
mem load -filltype value -filldata 20 -fillradix decimal /processor/Handler/R(4)
mem load -filltype value -filldata 30 -fillradix decimal /processor/Handler/R(3)
mem load -filltype value -filldata 40 -fillradix decimal /processor/Handler/R(2)
mem load -filltype value -filldata 50 -fillradix decimal /processor/Handler/R(1)
mem load -filltype value -filldata 60 -fillradix decimal /processor/Handler/R(0)
add wave -position insertpoint  \
sim:/processor/clock \
sim:/processor/interrupt \
sim:/processor/databus \
sim:/processor/PC \
sim:/processor/Instruction \
sim:/processor/Instruction1 \
sim:/processor/extras \
sim:/processor/extras1 \
sim:/processor/x \
sim:/processor/x1 \
sim:/processor/y \
sim:/processor/y1 \
sim:/processor/z \
sim:/processor/z1 \
sim:/processor/x2 \
sim:/processor/y2 \
sim:/processor/z2 \
sim:/processor/opcode \
sim:/processor/RegisterSourceAddress \
sim:/processor/RegisterDestAddress \
sim:/processor/RegisterSourceAddress1 \
sim:/processor/RegisterDestAddress1 \
sim:/processor/RegisterSourceValue \
sim:/processor/RegisterDestValue \
sim:/processor/RegisterSourceValue1 \
sim:/processor/RegisterDestValue1 \
sim:/processor/bufferde \
sim:/processor/bufferde0 \
sim:/processor/bufferem \
sim:/processor/bufferem0 \
sim:/processor/buffermw \
sim:/processor/buffermw0 \
sim:/processor/operation \
sim:/processor/operation2 \
sim:/processor/pcload
force -freeze sim:/processor/clock 1 0, 0 {50 ps} -r 100
