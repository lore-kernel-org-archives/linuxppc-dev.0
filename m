Reply-To: <kotaeji@secui.com>
From: "kotaeji" <kotaeji@secui.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: [Q] question about using x86 gdb to debug the remote ppc target (kgdb)
Date: Fri, 9 Jan 2004 14:41:10 +0900
Message-ID: <006701c3d673$30cb7890$2c373737@hwteam6549>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, I have a question about using kgdb on PowerPC (8245)

Is it possible that the host is x86, and the remote target
is powerpc as following picture ?

    HOST(x86)  ----------------------------- TARGET(ppc)
      gdb              serial line           kgdb patch

When I connect to target by gdb on x86 and do "info registers"
to show target registers, it shows x86 registers.

(gdb) info registers
eax            0x2000   8192
ecx            0xc3c6dd00       -1010377472
edx            0xc3c6c000       -1010384896
ebx            0xc0341540       -1070328512
esp            0xc0341400       0xc0341400
ebp            0xc3c6dd80       0xc3c6dd80
esi            0xc3c6de4c       -1010377140
edi            0x280008e8       671090920
eip            0x0      0x0
eflags         0x2      2
cs             0x0      0
ss             0xc5000000       -989855744
ds             0xfed2a80        267201152
es             0x10020300       268567296
fs             0x0      0
gs             0x0      0


Is there any way that I can use x86 gdb to debug remote ppc target?
Should I use powerpc gdb (like YellowDog) in order to debug
ppc target?

Any comments appreciated.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
