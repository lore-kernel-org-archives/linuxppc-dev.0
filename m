Content-Type: text/plain
MIME-Version: 1.0
Message-ID: <yJ989087856096.17193@webmail1.inner-21cn.com>
Date: Wed, 12 Sep 2001 14:39:03 +0800 (CST)
From: "yah" <hay8888@21cn.com>
To: linuxppc-embedded@lists.linuxppc.org
Cc: 
Subject: Romboot problem
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
  I'm trying to boot Linux from my custom board (MCP750).I compiled the kernel using zimage.initrd. And it can boot correctly via net. But when I fill it in the onboard flash, the system can't boot. Here are the boot trace.

ROMBoot about to Begin... Press <ESC> to Bypass, <SPC> to Continue
loaded at:     00005400 0001A224
relocated to:  00800000 00814E24
board data at: 07F88000 07F8EA0C
relocated to:  0080E318 00814D24
zimage at:     00010400 000D4EA0
relocated to:  00815000 008D9AA0
initrd at:     000D4EA0 00372F92
relocated to:  008DA000 00B780F2
avail ram:     00400000 00800000

Linux/PPC load: root=/dev/ram0 init=/bin/bash
Uncompressing Linux...done.
Now booting the kernel

Exception: Program (Illegal Instruction)
SRR0 =001AFB5C SRR1 =00080040 Vector-Offset =00700
IP     =001AFB5C MSR    =00000040 CR     =20000008 FPSCR  =00000000
R0     =0000044B R1     =0080E210 R2     =0080AE54 R3     =0080E318
R4     =008DA000 R5     =00B780F2 R6     =00814D24 R7     =00814D41
R8     =00000000 R9     =00000000 R10    =DEADC0DE R11    =00810000
R12    =00000001 R13    =00000000 R14    =00005400 R15    =00000000
R16    =00000000 R17    =00000000 R18    =00000000 R19    =00000000
R20    =00000000 R21    =00000000 R22    =00000000 R23    =00000000
R24    =00000000 R25    =00000000 R26    =00000000 R27    =00814D41
R28    =00814D24 R29    =00B780F2 R30    =008DA000 R31    =0080E318
SPR0   =7C651B78 SPR1   =20000000 SPR8   =00000028 SPR9   =00000000
001AFB5C E5E9AD38  WORD        $E5E9AD38

  What's wrong?
  Thanks for any advice.

Regards,
Amy

------------------------------------------------
"世纪邮箱，惊奇之旅"------奖品送不停
http://mail.21cn.com/promotion/828/index.html
100元上21cn，做分类广告
http://adinfo.21cn.com/price/001.html
携手合作，诚征代理
http://mail.21cn.com/business/005.html
眼光的较量，20万巨奖等你拿
http://10games.21cn.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
