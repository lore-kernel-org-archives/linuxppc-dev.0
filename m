Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3E5EF447.3B9088D7@tataelxsi.co.in>
Date: Fri, 28 Feb 2003 11:01:51 +0530
From: "Kamalesh B" <kamal@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: RAMDISK
References: <3E5650A4.39677CB0@tataelxsi.co.in> <3E565C04.9020603@embeddededge.com> <3E59BF74.8C163181@tataelxsi.co.in> <027c01c2dbdc$3fbf1290$e600a8c0@udtech.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

Right now, iam working booting Linux 2.4.1 on MPC8260ADS. Iam using NFS
option to boot the linux. Mount point is on the host PC.

Iam using PPCBOOT bootloader.

Command line argument for linux given is
root=/dev/nfs    nfsaddrs=<targetip>:<serverip>

My query is
1. How to boot linux-2.4.1 using root file system rather than using
network file system?
2. How to make ramdisk(root fs) part of linux kernel? DO i need to
change some makefiles or config options?
3. How to remove dependency of nfs to boot-up LINUX i.e, OS image should
boot in standalone setup?

thanks in advance,
with rgds,
kamal

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
