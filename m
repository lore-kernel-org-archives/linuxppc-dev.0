Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Wed, 30 Oct 2002 17:28:51 +0100
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: initrd problems
From: Anders Blomdell <anders.blomdell@control.lth.se>
To: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Message-Id: <ACFC1B4A-EC24-11D6-8213-0003931C2BFA@control.lth.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have created a compressed ramdisk of the root I'm currently using as NFS
root for my embedded system. When I try to boot it with the following boot
arguments:

   Linux/PPC load: console=ttyS0,9600 root=/dev/ram rw

it fails with:

   RAMDISK: Compressed image found at block 0
   Freeing initrd memory: 361k freed
   Kernel panic: VFS: Unable to mount root fs on 01:00

Anything very obvious that is wrong?

Regards

Anders Blomdell

------------------------------------------------------------------------------
  Anders Blomdell
  Department of Automatic Control        Email: anders.blomdell@control.lth.
se
  Lund Institute of Technology           Phone: +46 46 222 4625
  Box 118, S-221 00 Lund, Sweden         Fax:   +46 46 138118


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
