Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 73AA2DDE1B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Sep 2007 03:19:28 +1000 (EST)
Date: Thu, 20 Sep 2007 12:19:12 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Andrew Liu <shengping.liu@windriver.com>
Subject: Re: The  ds1337 chip on fsl_mp8313E RDB REVA 3 doesn't  work properly
Message-Id: <20070920121912.672c7ed2.kim.phillips@freescale.com>
In-Reply-To: <46F238BB.4040007@windriver.com>
References: <46F238BB.4040007@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 20 Sep 2007 17:09:15 +0800
Andrew Liu <shengping.liu@windriver.com> wrote:

> Hello All,
> The same u-boot/kernel/rootfs on fsl_mp8313E RDB REVA 2, DS1337  RTC
> chip can work,
> but on sl_mp8313E RDB REVA 3, it doesn't work, its time don't change.
> 
> This RTC chip  specific bad behavior on sl_mp8313E RDB REVA 3  as follows:
> (1) On U-Boot (from Freescale), run command:
> => i2c md 0x68 0x0
> 0000: 32 33 10 04 20 89 08 84 00 20 53 00 42 16 18 80    23.. .... S.B...

looks like your oscillator is turned off (80 in status reg).

There are many reasons this can happen - google for 'dallas 1337 rtc'
for the chip's documentation to help you diagnose.

Kim
