Return-Path: <blind_miksu@hotmail.com>
Received: from hotmail.com (bay12-f14.bay12.hotmail.com [64.4.35.14])
	by ozlabs.org (Postfix) with ESMTP id 28C2067A6C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 08:39:34 +1100 (EST)
Message-ID: <BAY12-F147D953D7254016B942F2994480@phx.gbl>
From: "veikko romppainen" <blind_miksu@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 16 Mar 2005 23:22:25 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Subject: porting linux & u-boot on Mdp Pro 8xx board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

I have currently running wxWorks on Mdp Pro 823 board. Now i'm trying port 
Linux on it. Firstable i have to get u-boot working on it. I hope someone 
has done this.

Is there working configuration from u-boot to this board?
I have modified QS823 conf, because it looks quite similar.

Can I use VisionIce 2 and SingleStep to flash u-boot?
We dont't have BDI in our school, shame. I flashed u-boot by using Ice 
starting at 0xfff00000. It seemed that it went correct place but nothing 
happened when i started my board.
I suppose that I can't  debug it with Ice and SingleStep.

Do i have to flash more than just u-boot.bin in right address? 
(Environment?)
Do i need  some reg files or prj files?

I would appreciate if someone could help me with these addresses and 
configs.

Board specs:
MPC 823 66 Mhz
4Mb flash
128 Mb RAM
512 K SRAM
8 K eeprom

Mika Nieminen

_________________________________________________________________
Nopeampi kuin sähköposti. Henkilökohtaisempi kuin chat. Lataa ilmainen MSN 
Messenger. http://messenger.msn.fi Lataa nyt koneellesi ilmainen MSN 
Messenger.
