Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: System crash in kernel_thread
Date: Tue, 3 Jun 2003 10:36:22 +0200
Message-ID: <742AC4678EF8464697DDDFE3B40F6ECD07E2CD@srv-mailrnd.azisa.co.za>
From: "Flavio Pereira" <Flavio.Pereira@za.flextronics.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Guys

I'm trying to port Linux to a proprietary board. I got u-boot working
good, and now that I start the kernel I find that the system _halts_
when it tries to run init using the kernel_thread routine in
init/main.c/rest_init(). Can someone suggest why this could be
happening?

This is my output:

Linux version 2.4.20 (fpereira@rigel) (gcc version 2.95.4 20010319
(prerelease/f
ranzo/20011204)) #17 Tue Jun 3 11:02:30 SAST 2003
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line:
Decrementer Frequency = 187500000/60
Warning: real time clock seems stuck!
Calibrating delay loop... 49.76 BogoMIPS
Memory: 30892k available (1048k kernel code, 380k data, 52k init, 0k
highmem)
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
