Message-Id: <200210211441.XAA18677@mail.highway.ne.jp>
Date: Mon, 21 Oct 2002 23:45:36 +0900 (JST)
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Reply-To: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: just compiled a 2.4.19 kernel with smp support...
To: grave@ipno.in2p3.fr
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


HI!

linuxppc kernel source is
rsync  -avz --delete rsync.penguinppc.org::linux-2.4-benh linux

My binary is

ftp://ppc.linux.or.jp/pub/users/fukui

Kaoru
---------------
My result is

[root@g4mpkfukui root]# uname -a
Linux g4mpkfukui 2.4.20-pre9_B0bsmp #1 SMP Wed Oct 16 16:15:11 JST 2002 ppc unknown
[root@g4mpkfukui root]#  cat /proc/cpuinfo
processor       : 0
cpu             : 7400, altivec supported
clock           : 450MHz
revision        : 2.9 (pvr 000c 0209)
bogomips        : 894.56

processor       : 1
cpu             : 7400, altivec supported
clock           : 450MHz
revision        : 2.9 (pvr 000c 0209)
bogomips        : 894.56

total bogomips  : 1789.13
machine         : PowerMac3,3
motherboard     : PowerMac3,3 MacRISC2 MacRISC Power Macintosh
detected as     : 65 (PowerMac G4 AGP Graphics)
pmac flags      : 00000004
L2 cache        : 1024K unified
memory          : 256MB
pmac-generation : NewWorld


On 21 Oct, Xavier Grave wrote:
>
> Hi,
>
> I've just compiled a 2.4.19 kernel with smp support but when I do a cat
> /proc/cpuinfo I can only see one processor ? Do I need to set something more
> than SMP=y in make config ?
>
> I'm using a debian kernel source package with the patches for powerpc.
>
> xavier
> PS:
> [root@ipnnarval ~]# uname -a
> Linux ipnnarval 2.4.19 #1 SMP Mon Oct 21 11:51:53 CEST 2002 ppc 0 7455,
> altivec supported GNU/Linux
> [root@ipnnarval ~]# cat /proc/cpuinfo
> processor       : 0
> cpu             : 7455, altivec supported
> clock           : 999MHz
> revision        : 2.1 (pvr 8001 0201)
> bogomips        : 999.42
>
> total bogomips  : 999.42
> machine         : PowerMac3,6
> motherboard     : PowerMac3,6 MacRISC2 MacRISC Power Macintosh
> detected as     : 95 (Unknown Keylargo-based)
> pmac flags      : 00000000
> L2 cache        : 256K unified
> memory          : 256MB
> pmac-generation : NewWorld
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
