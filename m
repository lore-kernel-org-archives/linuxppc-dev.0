Message-Id: <200210211341.PAA17882@ipnmail.in2p3.fr>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Xavier Grave <grave@ipno.in2p3.fr>
To: linuxppc-dev@lists.linuxppc.org
Subject: just compiled a 2.4.19 kernel with smp support...
Date: Mon, 21 Oct 2002 15:38:22 +0200
MIME-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I've just compiled a 2.4.19 kernel with smp support but when I do a cat
/proc/cpuinfo I can only see one processor ? Do I need to set something more
than SMP=y in make config ?

I'm using a debian kernel source package with the patches for powerpc.

xavier
PS:
[root@ipnnarval ~]# uname -a
Linux ipnnarval 2.4.19 #1 SMP Mon Oct 21 11:51:53 CEST 2002 ppc 0 7455,
altivec supported GNU/Linux
[root@ipnnarval ~]# cat /proc/cpuinfo
processor       : 0
cpu             : 7455, altivec supported
clock           : 999MHz
revision        : 2.1 (pvr 8001 0201)
bogomips        : 999.42

total bogomips  : 999.42
machine         : PowerMac3,6
motherboard     : PowerMac3,6 MacRISC2 MacRISC Power Macintosh
detected as     : 95 (Unknown Keylargo-based)
pmac flags      : 00000000
L2 cache        : 256K unified
memory          : 256MB
pmac-generation : NewWorld

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
