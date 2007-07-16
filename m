Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D220DDDE1E
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 08:19:00 +1000 (EST)
Message-ID: <469BEECC.6070404@freescale.com>
Date: Mon, 16 Jul 2007 17:18:52 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][PATCH 6/8] Walnut DTS
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>	
	<1184162389.32199.65.camel@weaponx.rchland.ibm.com>	
	<4EAC985A-2F04-465D-AB69-C67807310D7B@kernel.crashing.org>	
	<9696D7A991D0824DBA8DFAC74A9C5FA3030669AF@az33exm25.fsl.freescale.net>	
	<28A3F6B9-512B-4D86-8E0D-A7680CCE2354@kernel.crashing.org>	
	<1184622446.25235.89.camel@localhost.localdomain>	
	<469BE93E.1070702@freescale.com>
	<1184623898.25235.96.camel@localhost.localdomain>
In-Reply-To: <1184623898.25235.96.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> No, interrupt maps are useful in devices with no children in some corner
> cases. Remember that a map doesnt need to use the address part of the
> source specifier, thus it can be used to do a pure domain->domain
> conversion of the irq numbers, what sort of thing. The map has the added
> advantage that today, it's the only mechanism that allows you to specify
> different interrupt-parents through the same nexus, which is useful for
> 4xx.

OK...  but if you're doing a pure IRQ number conversion, the only useful 
#address-cells would be zero, which makes it a reasonable default IMHO 
(unlike the arbitrary 2 for regular traversal).

-Scott
