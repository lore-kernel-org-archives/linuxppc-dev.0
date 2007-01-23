Return-Path: <christophe.alayrac@cresitt.com>
Received: from smtp5-g19.free.fr (smtp5-g19.free.fr [212.27.42.35])
	by ozlabs.org (Postfix) with ESMTP id 6A684DDF29
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Jan 2007 03:25:42 +1100 (EST)
Subject: Re: ML403, 2.6.17.1 kernel panic
From: alayrac christophe <christophe.alayrac@cresitt.com>
To: Andrei Konovalov <akonovalov@ru.mvista.com>
In-Reply-To: <45B603C1.2070601@ru.mvista.com>
References: <1169556195.16144.3.camel@localhost.localdomain>
	<45B603C1.2070601@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 23 Jan 2007 18:25:27 +0100
Message-Id: <1169573127.5166.5.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: christophe.alayrac@cresitt.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Andrei,

Thanks for your help.

I've had a quick look in hardware design and as SGDMA is activated the
packet fifo is no accessible.

Do you think that some declarations are missing in xparameters_ml403.h
to properly declare SGDMA or is it coming from drivers code?


Note : 
 I use plb-temac v3.00a and hard_temac v3.00b, with EDK 8.2.02
 Kernel source from kernel.org (also tested with git linux-xilinx-26
from mvista)
 temac patch from mvista (PAULUS)
 
Regards

Chris

Le mardi 23 janvier 2007 à 15:46 +0300, Andrei Konovalov a écrit :
> Hi Chris,
> 
>  From you log it seems like the kernel tries to initialize the TEMAC's FIFO but fails.
> Do you have TEMAC configured in FIFO mode in your design?
> 
> Thanks,
> Andrei
> 
> alayrac christophe wrote:
> > Hi all,
> > 
> > I did not succeed to start kernel 2.6.17.1 on ML403 platform.
> > 
> > Any help would be appreciated.
> > 
> > Please foind log message here after
