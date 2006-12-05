Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D7E2467B93
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 15:43:26 +1100 (EST)
Subject: Re: What is the correct way to indicate an unassigned PCI resource ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
In-Reply-To: <Pine.LNX.4.60.0612042146040.6042@poirot.grange>
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
	<Pine.LNX.4.60.0612042146040.6042@poirot.grange>
Content-Type: text/plain
Date: Tue, 05 Dec 2006 15:43:12 +1100
Message-Id: <1165293792.29784.42.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olaf Hering <olaf@aepfle.de>, linux-ide@vger.kernel.org, greg@kroah.com,
	linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	Alan <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-12-04 at 21:53 +0100, Guennadi Liakhovetski wrote:
> On Mon, 4 Dec 2006, Sergei Shtylyov wrote:
> 
> > >>>   When Linus remaps IRQ0 on x86, I'll follow that code as a testament. Until 
> > >>>this happens, I consider is just an opinion. Forcing every arch but x86 to 
> > >>>remap IRQ0 is an example of the double standards.
> 
> Can I have a link to that specific answer from Linus, please? Somehow I 
> missed it.

That debate is pointless. arch/powerpc now always remaps and 0 is always
illegal as a logical IRQ number, while it's perfectly legal as a HW
number on any PIC, so there is no more problem. Other archs might
probably want to do a similar remapping anyway as it makes loads of
things easier when you have multiple PICs and/or dynamically assigned
numbers.

Ben.
