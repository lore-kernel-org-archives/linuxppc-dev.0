Return-Path: <markus.westergren@biologigrand.ac>
Received: from www.biologigrand.ac (biologigrand.ac [212.32.155.2])
	by ozlabs.org (Postfix) with ESMTP id 5674267A46
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 13 Feb 2005 23:52:52 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by www.biologigrand.ac (Postfix on SuSE Linux eMail Server 3.0) with
	ESMTP id 8B9B9584B63 for <linuxppc-embedded@ozlabs.org>;
	Sun, 13 Feb 2005 13:27:55 +0100 (CET)
Received: from 220a.licentiaten.umea.hsb.se (220a.licentiaten.umea.hsb.se
	[212.32.155.230])
	by www.biologigrand.ac (Postfix on SuSE Linux eMail Server 3.0) with
	ESMTP id A6455584283 for <linuxppc-embedded@ozlabs.org>;
	Sun, 13 Feb 2005 13:27:53 +0100 (CET)
Date: Sun, 13 Feb 2005 13:28:49 +0100 (CET)
From: Markus Westergren <markus.westergren@biologigrand.ac>
To: linuxppc-embedded@ozlabs.org
Message-ID: <Pine.LNX.4.50.0502131246140.3196-100000@220a.licentiaten.umea.hsb.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Support for Adder875 in Linux 2.4
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm working on a project which will use hardware based on Analogue & Micro
Adder875 module together with Linux 2.4.

I use RedBoot as bootloader and kernel 2.4.27-pre1, both came with the Adder
module.

The project require:

 - dual ethernet support with AM79C874 PHY
   The driver I've found (fec.c) only supports one ethernet. I'v started
	modifying a newer version of this driver which have support for my PHY. I
	have made some progress but it's not working yet. Found out that the first
	FEC is used to communicate with both PHY's. Both devices are detected
	correctly and the first seems to work but the second hangs the kernel when
	the first packet is sent or received.
 - SPI support
   Have found a simple driver (cpm_spi.c), which I have not tested yet.
 - PCMCIA support
   Will try to modify the m8xx_pcmcia driver.

Not required but would be good to have:
 - USB host support
   Have no clue where to start looking.

Have anyone used this module together with Linux and are there working drivers
for it? Any tips/ideas?

Thanks

/Markus

------------------
Markus Westergren
Biologigrand 17
S-907 32 Umea
SWEDEN
