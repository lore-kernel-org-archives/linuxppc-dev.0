Return-Path: <peter.asemann@web.de>
Received: from smtp05.web.de (smtp05.web.de [217.72.192.209])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3CA5B2BF4B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Nov 2004 23:42:38 +1100 (EST)
Received: from [131.188.52.27] (helo=[131.188.52.27])
	by smtp05.web.de with asmtp (TLSv1:RC4-MD5:128) (WEB.DE 4.102 #165)
	id 1CSEHT-0001UB-00
	for linuxppc-embedded@ozlabs.org; Thu, 11 Nov 2004 13:42:27 +0100
Message-ID: <41935E32.3090202@web.de>
Date: Thu, 11 Nov 2004 13:42:26 +0100
From: Peter Asemann <peter.asemann@web.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: peter.asemann@web.de
Subject: Which board is similar to mine, and how do I build a custom config?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Well... as you know I need to get that custom board running...

I read the U-BOOT readme and try to write my own config now.
Until now I just copied everything from esteem192e as it seemed most 
similar to my hardware to me, and renamed everything to "esm" which is 
the "codename" of the hardware.

Anyway, I'm not sure if there isn't a board that is more similar to mine 
which I missed, that's why I'm asking you:

The board will have an MPC875 at 133MHz speed.
It'll have an ethernet LXT970A PHY chip and an ISP1301 USB PHY chip for
net/usb, plus a three-pin serial interface connected directly to the CPU.

The RAM will consist of 2x K4S561632E SDRAM chips (2*32MB). The 2 chips 
each take 16bits from the 32bit address bus, chip1 0-15, chip2 16-31. 
For addressing the adress lines A17-A29 connect to both chips' inputs 
A0-A12, address lines A6 and A7 connect to the chips' inputs BA0 and BA1.

The flash will consist of 4x AM29LV160D chips, each getting 8 bits of
the 32bit data bus, all being connected to the 21bit wide adress bus. 
Address bus lines A1 to A20 connect to the chips' inputs A0-A19, the 
chips' inputs called D15/A1 are connected to address bus line A0.

There will be more hardware available on the board, but I won't bother 
with that as it's not important for the task of getting that PowerPC 
subsystem running, I suppose.

I could send you schematic diagrams of the layout as graphics if these 
explanations are not explanatory enough.

The README says of u-boot says for a custom config I'll need a 
u-boot.lds, a flash.c, a board.c and some more things. Do I need to 
change anything about the u-boot.lds, the flash.c or the board.c - I 
hope a custom .../include/configs/ESM.h will suffice?

Enough questions for today.

Peter Asemann
