Return-Path: <ejohnson@acdstar.com>
Received: from mail.acdstar.com (mail.acdstar.com [209.98.244.9])
	by ozlabs.org (Postfix) with ESMTP id 2F6BD67B4F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Apr 2005 08:46:19 +1000 (EST)
Received: from zaphod.acdstar.com (zaphod.int.acdstar.com [192.168.2.100])
	by mail.acdstar.com (8.13.0/8.13.0) with ESMTP id j3CMnFWq010044
	for <linuxppc-embedded@ozlabs.org>; Tue, 12 Apr 2005 17:49:15 -0500
Message-Id: <6.2.1.2.1.20050412173010.02adaaa0@mail.int.acdstar.com>
Date: Tue, 12 Apr 2005 17:46:03 -0500
To: linuxppc-embedded@ozlabs.org
From: "Eric N. Johnson (ACD)" <ejohnson@acdstar.com>
In-Reply-To: <20050412211342.B7C92C108D@atlas.denx.de>
References: <Your message of "Tue, 12 Apr 2005 14:38:20 CDT."
	<6.2.1.2.1.20050412143653.02ae7720@mail.int.acdstar.com>
	<20050412211342.B7C92C108D@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Subject: Re: MPC5200 I2S driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

At 04:13 PM 4/12/2005, Wolfgang Denk wrote:
>i2s.c is not really a driver, but a (very OLD) test  version  of  one
>used  to  demonstrate  certain  BestComm  related problems. Don't try
>using it as a real driver ;-)

Humm, any pointers on writing our own driver then then?  Digging through 
the source for other drivers, bestcomm seems to be a real house of 
cards.  We just want simple audio output capability.  No need to make it 
work with the standard Linux/OSS sound API.

Where can we keep track of the eratta/bugs in bestcomm?  Browsing through 
the mailing list, I've found references that:
   IDE and Ethernet DMA can't work at the same time
   I2S TX and RX DMA can't work at the same time
   AC-97 is terminally broken (no way to handle the slot tags properly
          for variable sampling rates)
Are these all still true?

We've tried asking our local Freescale rep, but they seem to think that 
Linux==Metrowerks, and they are looking into the bestcomm question, but 
official responses from Freescale tend to take >1 week.

This is for a custom MPC5200 board, heavily based on IceCube with a single 
I2S DAC on PSC2 running in "CODEC with MCLK" mode.

Sorry about the null subject line previously: fingers were working faster 
than brain...

Thanks
Eric


------------------------------------
Eric Johnson, Electrical Engineer
Advanced Communication Design
   7901 12th Avenue South
   Bloomington, MN 55425
Ph: 952-854-4000  Fax: 952-854-5774
