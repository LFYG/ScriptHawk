[Print]: 0x802F7870
[Return]: 0x8024EE90

[XPos]: 0x8037B7A0
[YPos]: 0x8037B7A4
[ZPos]: 0x8037B7A8
[PositionStringLength]: 6

// .org 0x80400000
PUSH ra
PUSH a0
PUSH a1
PUSH a2
PUSH a3

LI a0 0x10 // X Pos
LI a1 0x10 // Y Pos
LI a2 0xBF000666 // Unknown param
LA a3 XPosStr

JAL @Print
NOP

LI a0 0x10 // X Pos
LI a1 0x20 // Y Pos
LI a2 0xBF000666 // Unknown param
LA a3 YPosStr

JAL @Print
NOP

LI a0 0x10 // X Pos
LI a1 0x30 // Y Pos
LI a2 0xBF000666 // Unknown param
LA a3 ZPosStr

JAL @Print
NOP

POP a3
POP a2
POP a1
POP a0
POP ra
J @Return
NOP

XPosStr:
.asciiz "X POS"
YPosStr:
.asciiz "Y POS"
ZPosStr:
.asciiz "Z POS"
