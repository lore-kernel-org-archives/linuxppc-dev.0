Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F3571DE00A
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 22:37:07 +1100 (EST)
In-Reply-To: <20070323031956.GB28006@localhost.localdomain>
References: <20070316172846.GF29784@ld0162-tx32.am.freescale.net>
	<36990c5c3b7de1ab2f65662547641b79@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302B97B1A@az33exm25.fsl.freescale.net>
	<4b0f0296e3beb792337a868c3527c954@kernel.crashing.org>
	<20070322002911.GD2295@localhost.localdomain>
	<28ff7492856c7220f060cd113329e62f@kernel.crashing.org>
	<20070323031956.GB28006@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1f513f9b14cfe469ffee3d8e10901776@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 06/17] Document the linux,network-index property.
Date: Fri, 23 Mar 2007 12:36:58 +0100
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[...flat device tree labels...]

> They're of no use at present if you compile direct to dtb.  They're
> potentially useful, however, if you compile to asm output, because the
> labels are transcribed into symbols within the asm.
>
> The idea is intended to be useful for systems where the bootloader has
> to do some poking of the device tree, but doesn't need to change the
> size of any properties.

Nor needs to change any device tree structure (add/remove
properties / nodes).

> In that case the bootloader can do all the
> necessary fixups on the tree without *any* understanding of the flat
> tree structure.

Well it still needs to know property encoding...

> It simply links in the device tree structure, and
> symbols within it reference all the necessary points for adjustment.

Yeah.  That would be useful if you really only need to change
the contents of a few fixed-size properties.

It would be interesting to see if anyone actually uses this
feature ;-)


Segher
