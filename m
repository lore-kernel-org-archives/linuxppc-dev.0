Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3C9B393E.4958C98E@ftel.co.uk>
Date: Fri, 22 Mar 2002 14:01:34 +0000
From: Yonghao Wang <Y.Wang@ftel.co.uk>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Kernel message missing characters!
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello experts,

Help needed! I am trying porting linux on our MPC8260 board using
ppcboot as boot loader and kernel 2.4.7. The console is set up on serial

SMC2. I've changed little bit code on arch/ppc/boot/mbx/m8260_tty.c to
enable it supports SMC2. But when I boot kernel,  the console output
seems missing characters like below:

=> bootm a00000
bootm a00000
## Booting image at 00a00000 ...
   Image Name:   2.4.7-01 for initrd on ATMC8260
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    503628 Bytes = 491 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

Ttlmmr  2M;uig0Bfrhs al a 0000
Lnxvrin247 wn@ihmr.tlc.k gcvrin30 1FiMr1 53:7GT20
oe0:378pgs:378
oe2:0pgs.
Kre omn ie ot/e/f wnsot121..4:epr/p-f-oti=7.61.1:7.6213121..1:5.5..:iuAM

airtn ea op. 3.9BgMP
eoy 268 vial 82 enlcd,28 aa 2 nt khgmm

etyccehs al nre:134(re:5 302bts
nd-ah ahtbeetis 12(re:4 53 ye)Mutccehs al nre:24 odr ,134bts
ufrccehs al nre:89 odr ,378bts
aeccehs al nre:378(re:5 302bts
OI ofrac etn yUII
ae pnSasaUiest optrSceyNT.3
Satn sadv.
CMUR rvrvrin00

tS0a x00i  M

Does anybody can give me some clue how to fix it?

I'm new in embedded area. Thanks a lot!

Wang Yonghao


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
