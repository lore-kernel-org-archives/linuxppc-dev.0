Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id E0BCE68A23
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jan 2006 19:15:15 +1100 (EST)
Date: Thu, 12 Jan 2006 09:15:13 +0100 (MET)
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
MIME-Version: 1.0
References: <1137041067.7774.25.camel@localhost.localdomain>
Message-ID: <19351.1137053713@www55.gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
Subject: Re: AGPGART driver for ArticiaS - ioremap() problem
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

> --- Urspr¸ngliche Nachricht ---
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Gerhard Pircher <gerhard_stamer@gmx.net>
> Kopie: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
> Betreff: Re: AGPGART driver for ArticiaS - ioremap() problem
> Datum: Thu, 12 Jan 2006 15:44:27 +1100
> 
> On Wed, 2006-01-11 at 22:00 +0100, Gerhard Pircher wrote:
> > Hi,
> > 
> > David Bentam and I are trying to get a AGPGART driver working for the
> > AmigaOne and the Pegasos1. The driver detects the aperture size of the
> > ArticiaS AGP bridge, but fails at the ioremap() function in the generic
> > GATT table create function. Does the PowerPC platform behaves
> > differently for the mapping of address location for AGP operation than
> > the x86 platform? Is it possible to use a mask to relocate the AGP
> > address space to a specific location?
> 
> Well, what value are you passing to ioremap ?
> 
> Ben.
>
Please take a look at the end of my previous mail, where I included the
debug messages of the driver and the driver code itself. The log shows that
the physical address is mapped (IMHO) to the PCI memory range (>
0x0c0000000). Is this correct? Shouldn't it be mapped to the system memory
address range?

The aperture size is 4MB, page_order should be 1 and num_entries = 1024.

Hope this helps!? :-)

Thanks!

Regards,

Gerhard

-- 
DSL-Aktion wegen groﬂer Nachfrage bis 28.2.2006 verl‰ngert:
GMX DSL-Flatrate 1 Jahr kostenlos* http://www.gmx.net/de/go/dsl
