Message-ID: <3EE07891.7070507@austin.rr.com>
Date: Fri, 06 Jun 2003 06:18:41 -0500
From: Johns Daniel <jdaniel6@austin.rr.com>
MIME-Version: 1.0
To: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Running Linux From RAM
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I would like to do some short-term development work on an evaluation
board. I was wondering whether I would be able to do this without
writing anything to the on-board FLASH -- which does have an embedded
monitor that will perform board initialization.

It is an 8260 board, and I have BDI2000 working on it. I can think of
two possibilities:
1. Use the BDI to download the Linux image to SDRAM. Execute the "go
<address>" command of the embedded monitor or the BDI.
2. Use the BDI to download U-Boot to SDRAM. Then get U-Boot to load the
Linux kernel.

Unfortunately, I need some more information:
- what Linux kernel target to make (make zImage?)
- what address to download the kernel or U-boot to
- what address to go to
- any customization necessary (e.g., hard code board info into the
embed_config.c file of arch/ppc/boot/simple/.)
- any sequence of steps that are critical

Any pointers or suggestions would be welcome!

-- Johns


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
