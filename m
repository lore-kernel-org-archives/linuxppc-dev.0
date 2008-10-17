Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id DD41EDDE01
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Oct 2008 18:00:12 +1100 (EST)
Message-ID: <48F8384A.6090901@coritel.it>
Date: Fri, 17 Oct 2008 09:01:30 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Mark Bishop <mark@bish.net>
Subject: Re: How can I make flash writeable?
References: <20081016144526.tjuq1t5mgw4ks4co@www.bish.net>
In-Reply-To: <20081016144526.tjuq1t5mgw4ks4co@www.bish.net>
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Mark,

> How can I tell which devices are mapped to /proc/mtd devices?

If I well understand the question, you'd like to change the partitions
layout (?), so you should check out the dts file to see the flash
layout, then you can specify there the partitions and change the
dimensions, if they are read-only...and so on.

Regards,

Mark Bishop ha scritto:
> I am using the MPC8313E-RDB and I am having some problems using the
> flash that comes on the board.  Let me preface this by saying that I
> haven't worked in the embedded linux arena in about 10 years so I am
> trying to catch up with all the new toys.
> 
> This board uses uBoot and it currently has 128M of DDR2, 8M flash and
> 32M NAND Flash.  I have a few questions:
> 
> How can I tell which memory device it uses to boot out of?
> How can I tell which devices are mapped to /proc/mtd devices?
> 
> 
> I want to create a writeable flash partition, is there a FAQ out there I
> could look at.
> 
> All of this is after a few days of using Google to try and glean some
> data from the internet.  And the books don't get here from Amazon until
> Monday.
> 
> I would appreciate any help.  Even a RTFM - if you could point me to
> TFM, it would greatly help.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 

-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838
