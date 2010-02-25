Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 65A0CB7C67
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2010 09:36:40 +1100 (EST)
Subject: Re: PCI on 834x
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <4B86E5A7.9090607@freescale.com>
References: <4B854A93.7030405@mlbassoc.com>	<4B85746F.3020200@freescale.com>
	<4B857AA8.9000208@mlbassoc.com>	<4B857EA1.6030605@freescale.com>
	<4B858243.8010908@mlbassoc.com>	<4B858B6C.4020809@freescale.com>
	<20100224205159.GA6555@oksana.dev.rtsoft.ru>
	<4B85A4C2.6090007@mlbassoc.com>
	<A0F7894F-8B88-4646-8B81-830F67E39489@kernel.crashing.org>
	<4B85B182.2030508@mlbassoc.com>  <4B86886B.5000304@mlbassoc.com>
	<1267130982.23523.1728.camel@pasglop> <4B86E5A7.9090607@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 26 Feb 2010 09:36:21 +1100
Message-ID: <1267137381.23523.1731.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, avorontsov@ru.mvista.com,
	Gary Thomas <gary@mlbassoc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-02-25 at 15:03 -0600, Scott Wood wrote:
> 
> It can, but I don't see how that would help, if the problem is that the 
> video card doesn't like the low 30 bits of its MMIO address being zero.

My idea was the video card, if it's an old piece of shit, may not be
decoding all address bits.

> Gary, can you check that the MMIO addresses are going to the PCI bus 
> as-is, and aren't being translated down to zero?  I.e. POTARn should 
> equal POBARn, and likewise in the device tree's pci node's ranges.

Cheers,
Ben.
