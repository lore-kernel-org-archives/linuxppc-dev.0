Return-Path: <markus.westergren@biologigrand.ac>
Received: from www.biologigrand.ac (biologigrand.ac [212.32.155.2])
	by ozlabs.org (Postfix) with ESMTP id F2A5567A77
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Feb 2005 06:44:31 +1100 (EST)
Date: Mon, 14 Feb 2005 20:44:28 +0100 (CET)
From: Markus Westergren <markus.westergren@biologigrand.ac>
To: Yuli Barcohen <yuli@arabellasw.com>
In-Reply-To: <16912.18711.885679.679568@astp0002.localdomain>
Message-ID: <Pine.LNX.4.50.0502142031110.28518-100000@220a.licentiaten.umea.hsb.se>
References: <Pine.LNX.4.50.0502131246140.3196-100000@220a.licentiaten.umea.hsb.se>
	<16912.18711.885679.679568@astp0002.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Support for Adder875 in Linux 2.4
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 14 Feb 2005, Yuli Barcohen wrote:

> >>>>> Markus Westergren writes:
>
>     Markus> Hi, I'm working on a project which will use hardware based
>     Markus> on Analogue & Micro Adder875 module together with Linux 2.4.
>
>     Markus> I use RedBoot as bootloader and kernel 2.4.27-pre1, both
>     Markus> came with the Adder module.
>
>     Markus> The project require:
>
>     Markus> - dual ethernet support with AM79C874 PHY
>     Markus>    The driver I've found (fec.c) only supports one
>     Markus>    ethernet. I'v started
>     Markus> 	modifying a newer version of this driver which have
>     Markus> 	support for my PHY. I have made some progress but it's
>     Markus> 	not working yet. Found out that the first FEC is used to
>     Markus> 	communicate with both PHY's. Both devices are detected
>     Markus> 	correctly and the first seems to work but the second
>     Markus> 	hangs the kernel when the first packet is sent or
>     Markus> 	received.
>     Markus> - SPI support
>     Markus>    Have found a simple driver (cpm_spi.c), which I have not
>     Markus>    tested yet.
>     Markus> - PCMCIA support
>     Markus>    Will try to modify the m8xx_pcmcia driver.
>
>     Markus> Not required but would be good to have:
>     Markus> - USB host support
>     Markus>    Have no clue where to start looking.
>
>     Markus> Have anyone used this module together with Linux and are
>     Markus> there working drivers for it? Any tips/ideas?
>
> Arabella Linux supports all these. Not sure how you are going to use
> PCMCIA on this specific board - it's not connected.
>
The board in my project is almost like a Adder875 but unlike the Adder it has a
PCMCIA slot connected.

I have tested a version of Arabella (FREE v2.1, kernel 2.4.25). It looks like
that the fec driver only supports general PHY and no link interrupts.

/Markus
