Message-ID: <41EDEC3C1B88D51186EB00A0C9CFADF702FA81@AMWMAIL>
From: Cindy Peters <cinpet@adaptivemicro.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Upgrading to kernel 2.4.6 with old init program
Date: Fri, 21 Sep 2001 15:29:29 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am upgrading my Linux kernel from 2.2.13 to 2.4.6 on an MPC823. When the
kernel startup process gets to running the sbin/init program I am getting a
usage error for ld.so and then a kernel panic. It looks like it is
attempting to run ld.so. I am still using an old ramdisk with old versions
of executables that ran successfully on Linux 2.2.13. Have the file formats
changed somehow? Do I need to get the source for the executables and rebuild
them with the latest libraries? If so, where can I get them?

Thanks,

Cindy Peters
Adaptive Micro-Ware, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
