Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id A655767B92
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Jul 2005 01:56:33 +1000 (EST)
Message-ID: <42C4162E.4030602@anagramm.de>
Date: Thu, 30 Jun 2005 17:56:30 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <42C40BD0.8040408@anagramm.de>
	<658739DB-540F-4AFC-80DC-BBF0C2AD70F4@freescale.com>
In-Reply-To: <658739DB-540F-4AFC-80DC-BBF0C2AD70F4@freescale.com>
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

Hi, Kumar...

> I'm not aware of anyone work on such a thing.

*Sigh*... no holiday for me this summer .-(

> I'd be more than happy  
> to accept patches for it.  I know several of us have written some  APIs 
> on top of the DMA for 85xx.  Those however are non-standard APIs.

But is there any code available for recycling?
Are there any Freescale-FAE's with some snippets?
(Hello, world!)
I am about to start more or less from scratch and re-invent the wheel.

> What APIs exist for general purpose DMA engines?  Last time I looked  at 
> this problem nothing really existed.

:-) I was wondering about that, too...
Maybe we can get some basics from this one:
Linux/Documentation/DMA-API.txt

And, well, code from:
asm-ppc/ppc4xx_dma.h
arch/ppc/syslib/ppc4xx_sgdma.c
and from the pci.h subsystem.

Hmm... and there is the factor that it's difficult to get
resources in my project for all that. :-(((

Best greets,

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
