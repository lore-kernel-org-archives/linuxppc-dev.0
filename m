Return-Path: <yuli@arabellasw.com>
Received: from gold.webfusion.co.uk (gold.webfusion.co.uk [212.67.202.159])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 08EAE67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Feb 2005 17:46:02 +1100 (EST)
From: Yuli Barcohen <yuli@arabellasw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16912.18711.885679.679568@astp0002.localdomain>
Date: Mon, 14 Feb 2005 08:45:43 +0200
To: Markus Westergren <markus.westergren@biologigrand.ac>
In-Reply-To: <Pine.LNX.4.50.0502131246140.3196-100000@220a.licentiaten.umea.hsb.se>
References: <Pine.LNX.4.50.0502131246140.3196-100000@220a.licentiaten.umea.hsb.se>
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

>>>>> Markus Westergren writes:

    Markus> Hi, I'm working on a project which will use hardware based
    Markus> on Analogue & Micro Adder875 module together with Linux 2.4.

    Markus> I use RedBoot as bootloader and kernel 2.4.27-pre1, both
    Markus> came with the Adder module.

    Markus> The project require:

    Markus> - dual ethernet support with AM79C874 PHY
    Markus>    The driver I've found (fec.c) only supports one
    Markus>    ethernet. I'v started
    Markus> 	modifying a newer version of this driver which have
    Markus> 	support for my PHY. I have made some progress but it's
    Markus> 	not working yet. Found out that the first FEC is used to
    Markus> 	communicate with both PHY's. Both devices are detected
    Markus> 	correctly and the first seems to work but the second
    Markus> 	hangs the kernel when the first packet is sent or
    Markus> 	received.
    Markus> - SPI support
    Markus>    Have found a simple driver (cpm_spi.c), which I have not
    Markus>    tested yet.
    Markus> - PCMCIA support
    Markus>    Will try to modify the m8xx_pcmcia driver.

    Markus> Not required but would be good to have:
    Markus> - USB host support
    Markus>    Have no clue where to start looking.

    Markus> Have anyone used this module together with Linux and are
    Markus> there working drivers for it? Any tips/ideas?

Arabella Linux supports all these. Not sure how you are going to use
PCMCIA on this specific board - it's not connected.

-- 
========================================================================
 Yuli Barcohen       | Phone +972-9-765-1788 |  Software Project Leader
 yuli@arabellasw.com | Fax   +972-9-765-7494 | Arabella Software, Israel
========================================================================
