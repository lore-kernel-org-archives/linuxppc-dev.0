Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Thu, 9 Jan 2003 10:05:50 +0100
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Booting Linux from an already running linux
From: Anders Blomdell <anders.blomdell@control.lth.se>
To: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Message-Id: <8CD0F4AF-23B1-11D7-98E2-0003931C2BFA@control.lth.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Now that I have a Linux running with networking on a PrPMC800 running as
NON-MONARCH, I wonder if anybody knows about a program that can start a
fresh linux kernel from the filesystem. The reason I need this, is that the
PrPMC800 PPC-Bug does not support network booting for NON-MONARCH operation
(neither have I found any alternative that does), and downloading megabytes
over the serial line is not very tempting.

In theory it should be simple (given that we have enough RAM):

   1. Load the new image into RAM (userspace)
   2. Disable interrupts
   3. Copy image from userspace RAM to contiguous (physical) memory
   4. Jump to code in the contiguos (physical) memory

Does anybody know of such a program?

Regards

Anders Blomdell


------------------------------------------------------------------------------
  Anders Blomdell
  Department of Automatic Control        Email: anders.blomdell@control.lth.
se
  Lund Institute of Technology           Phone: +46 46 222 4625
  Box 118, S-221 00 Lund, Sweden         Fax:   +46 46 138118


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
