Return-Path: <alebas@televes.com>
Received: from tvesnat.televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with ESMTP id E1BC6679EB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Apr 2006 22:51:02 +1000 (EST)
Message-ID: <1145458791.44465067c4afa@webmail.televes.com:443>
Date: Wed, 19 Apr 2006 16:59:51 +0200
From: Bastos Fernandez Alexandre <alebas@televes.com>
To: Mark Chambers <markc@mail.com>
Subject: Re: Watchdog on MPC82xx
References: <1144835330.443ccd021b40a@webmail.televes.com:443><1144842264.443ce818d6822@webmail.televes.com:443>
	<1145445235.44461b733f242@webmail.televes.com:443>
	<005401c663a9$e1fd8930$6401a8c0@CHUCK2>
In-Reply-To: <005401c663a9$e1fd8930$6401a8c0@CHUCK2>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Mark,

>
> I haven't been following this closely, but are you sure it's a WDT
> reset?  You can tell from the Reset Status Register (RSR).
> u-boot prints out a decode of this register, which also clears the
> bits, so you have to go by the printout when u-boot starts to see
> why the last reset occurred.

U-boot is reporting the Watchdog reset. You can see:

U-Boot 1.1.4 (Apr 11 2006 - 14:39:01)

MPC8272 Reset Status: Software Watchdog, External Soft, External Hard

MPC8272 Clock Configuration
 - Bus-to-Core Mult 4x, VCO Div 2, 60x Bus Freq  25-75 , Core Freq 100-300
 - dfbrg 1, corecnf 0x1a, busdf 3, cpmdf 1, plldf 0, pllmf 3
 - vco_out  400000000, scc_clk  100000000, brg_clk   25000000
 - cpu_clk  400000000, cpm_clk  200000000, bus_clk  100000000
 - pci_clk   66666666

CPU:   MPC8272 (HiP7 Rev 14, Mask 1.0 1K50M) at 400 MHz
Board: Televes XXX8248
       Watchdog enabled


>
> Just trying to help brainstorm...
>
> Mark Chambers
>

Thanks,

Alex Bastos
