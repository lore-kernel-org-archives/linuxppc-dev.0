Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <41EDEC3C1B88D51186EB00A0C9CFADF702FA6C@AMWMAIL>
From: Cindy Peters <cinpet@adaptivemicro.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Problem during decompressing kernel routine
Date: Mon, 10 Sep 2001 09:20:18 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am upgrading to kernel version 2.4.6 from version 2.2.13. I have followed
through the boot loader code and everything seems to be running correctly. I
see the following messages:

loaded at:	00200000   0020FBF0
relocated at:	00100000   0010FBF0
board data at:	001001F8   00100214
relocated to:	00200100   0020011C
zimage at:	00205328   00277584
initrd at:		00277584   0046B35B
relocated to:	00E0C000  00FFFDF8
avail ram:	00278000   00600000

Linux/PPC load: root=/dev/ram
Uncompressing Linux...

An image with the same boot loader and the old kernel will run just fine. I
have examined the header of the vmlinux.gz file and compared it to the old
version and it looks OK.

Does anyone have any ideas of what the problem is?

Thanks,

Cindy Peters
Adaptive Micro-Ware, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
