Return-Path: <Frank.Prepelica@ubidyne.com>
Received: from mail.ubidyne.com (mail.ubidyne.com [212.211.133.238])
	by bilbo.ozlabs.org (Postfix) with ESMTP id B4FADB70E5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 19:45:08 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: AW: How to set DDR data bus width to 16Bit
Date: Thu, 2 Jul 2009 11:45:04 +0200
Message-ID: <29DC34A6B43468409F5A371CFE34E849D7F193@ex01.ads.ubidyne.de>
From: "Frank Prepelica" <Frank.Prepelica@ubidyne.com>
To: "Norbert van Bolhuis" <nvbolhuis@aimvalley.nl>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> you have to do it via your bootloader (u-boot) which sets up
> the DDR memory controller.
> Linux (already) assumes memory is available.
> Are you sure linux kernel is changing DDR_SDRAM_CFG ?
> When our linux-2.6.28 kernel is up, it's still 0xc3080000 when I read
> physical address 0xe0002110.


Hi Norbert, thank you for your fast reply!

You are absolutly right! I made a silly mistake. I've read the value of
the 0xe0002110 with a 8bit pointer.

The value is actually 0xC3100000 which means the 16bit bus width is set.

Just to be sure. Is this the only change (in the bootloader) I have to
make that all data accesses are 16bit wide?

> Btw. We did some performance tests with 16 bit bus-width (DDR2 memory)
> and surprisingly performance was almost as good as 32 bit bus-width

This is exactly our intention to test. Thanks for that hint. Very good
to
know!

Thank you.

Best regards
Frank
