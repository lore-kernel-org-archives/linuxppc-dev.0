Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id 323C967BF2
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Jul 2005 17:47:28 +1000 (EST)
Message-ID: <42C4F50D.3050405@anagramm.de>
Date: Fri, 01 Jul 2005 09:47:25 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
References: <42C40BD0.8040408@anagramm.de>
	<658739DB-540F-4AFC-80DC-BBF0C2AD70F4@freescale.com>
	<42C4162E.4030602@anagramm.de>
	<427c70958bb995dad4fbad2e6ff121bc@embeddededge.com>
In-Reply-To: <427c70958bb995dad4fbad2e6ff121bc@embeddededge.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC85xx DMA support for Kernel 2.6?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Dan!

Dan Malek wrote:
> Before you start, just make sure such a thing is really a performance
> enhancement.  Yes, the DMA does run in parallel with the core, but often
> the overhead of the set up and clean up interrupt is more code and time
> that if you just copied the data in a loop.  If possible, integrate the DMA
> processing into other driver work, clean up a previous DMA the next time
> the driver needs to use it, not with a separate completion handler.

Well... thanks. But the CPU is intended to do image processing while
data comes in. And currently, when I access (memcopy) the SRAM on my
Local Bus via UPM I cannot get it to generate bursts yet, so I hope the
DMA will speed up those things, too.

Greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
