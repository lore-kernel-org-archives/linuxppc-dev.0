To: linuxppc-embedded@lists.linuxppc.org
Subject: mcpn765
From: bjowi@ida.liu.se (=?iso-8859-1?q?Bj=F6rn?= Wingman)
Date: 15 Mar 2001 16:44:30 +0100
Message-ID: <yx2r8zzghpd.fsf@aste15.ida.liu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I have an MCPN765 card from Motorola with a 7400 processor, and I'm
trying to boot linux on it. I use the latest hardhat cross-compilation
tools, all with the prefix ppc_7xx, which seemed to be the correct choice.

I have set up bootp and so on on my host machine, and transferring the
kernel image seems to work fine, but all kernels I have tried refuse to boot.

>From ppcbug I get:

Residual-Data Located at: $1FF8D93C

...and then nothing happens.


There is a kernel image on

http://www.linuxcare.com.au/download/ppclinux/mcpn765/zImage

that gets a bit further:

Residual-Data Located at: $1FF8D93C
loaded at:     00005400 0001C210
relocated to:  00800000 00816E10
board data at: 1FF8D93C 1FF94348
relocated to:  00810304 00816D10
zimage at:     00010400 000A78CB
relocated to:  00817000 008AE4CB
avail ram:     00400000 00800000

Linux/PPC load: console=ttyS0,9600 root=/dev/sda2 mem=992m
Uncompressing Linux...done.
Now booting the kernel
vector 300: at pc = 9000db1c, msr = 1032, sp = 9012bf88 [9012bed8]
dar = fe000cf8, dsisr =42000000
current = 9012a058, pid = 0, comm = swapper
mon>

And I end up in some sort of boot-monitor-debugger that I don't know
anything about.


But if I compile the sources provided at linuxcare myself, I get the same
behaviour as before.

Any ideas? Do I need a different crosscompiler?


       /Björn Wingman

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
