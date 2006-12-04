Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 5EFD067BED
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 07:53:18 +1100 (EST)
Date: Mon, 4 Dec 2006 21:53:06 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: What is the correct way to indicate an unassigned PCI resource ?
In-Reply-To: <457444E3.7030706@ru.mvista.com>
Message-ID: <Pine.LNX.4.60.0612042146040.6042@poirot.grange>
References: <20061130165202.GA23205@aepfle.de>
	<20061204123854.GA28159@aepfle.de>
	<FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>
	<4574197A.2020204@ru.mvista.com>
	<4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>
	<45741DDE.4080509@ru.mvista.com>
	<20061204132124.4f7c50a9@localhost.localdomain>
	<45742253.1000807@ru.mvista.com>
	<20061204142201.68d9621f@localhost.localdomain>
	<457431FE.6040702@ru.mvista.com>
	<20061204144411.246f3700@localhost.localdomain>
	<45744159.8040301@ru.mvista.com> <457444E3.7030706@ru.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Olaf Hering <olaf@aepfle.de>, linuxppc-dev@ozlabs.org, greg@kroah.com,
	linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
	Alan <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 4 Dec 2006, Sergei Shtylyov wrote:

> >>>   When Linus remaps IRQ0 on x86, I'll follow that code as a testament. Until 
> >>>this happens, I consider is just an opinion. Forcing every arch but x86 to 
> >>>remap IRQ0 is an example of the double standards.

Can I have a link to that specific answer from Linus, please? Somehow I 
missed it.

>     Although, I'm getting the point -- PCI is likely to return 0 for 
> unassigned the interrupt line register (this isn't always true though).  So, 
> some mixup is possible in that regard.  Well, then we're unlucky, and indeed 
> remapping IRQ0 has sense...

Strange, if __PCI__ uses 0 for an unassigned IRQ line, I'd say it's 
_internal_ PCI peculiarity, and should be handled by the PCI code, and not 
be taken as an enforced definition by all architectures for the whole 
system.

Why does one HAVE to remap IRQs if on a specific system it is easy and 
natural to use 0 as a valid IRQ number?

Thanks
Guennadi
---
Guennadi Liakhovetski
