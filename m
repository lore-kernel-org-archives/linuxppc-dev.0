Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3439AB3A99ECD5409F3A52ACF814744D158D36@norcom2.norcom.net>
From: Lokesh Kumar <lokesh.kumar@wrx-us.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Booting linux on MPC custom Board 
Date: Sun, 22 Jun 2003 13:32:17 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I have a custom board with a custom bootloader. The board is based on
MPC855T, with 8MB flash and 32MB RAM.

I have to boot linux on this board. The issue I have is this - I have to use
the custom bootloader (to be able to boot older app as well). I think I have
two ways to go -

1. Custom bootloader enhanced to be able to load Linux. I do not think it is
faster approach given the time required.

2. Tell custom bootloader to load another bootloader like PPCBOOT (U-BOOT)
and then let it load Linux. Now, to go this route, I will have to run
PPCBOOT from RAM. Reading documentation of PPCBOOT, it says that it runs
from FLASH and relocates itself to RAM.
	How can run PPCBOOT from RAM directly and then tell it to load
Linux?? Any HELP would be appreciated.


Lokesh Kumar
Wireless Matrix USA Inc.
703-262-4032


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
