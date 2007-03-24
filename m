Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6165DDDFDC
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Mar 2007 11:24:10 +1100 (EST)
In-Reply-To: <20070323235900.GH4459@localhost.localdomain>
References: <20070316172846.GF29784@ld0162-tx32.am.freescale.net>
	<36990c5c3b7de1ab2f65662547641b79@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302B97B1A@az33exm25.fsl.freescale.net>
	<4b0f0296e3beb792337a868c3527c954@kernel.crashing.org>
	<20070322002911.GD2295@localhost.localdomain>
	<28ff7492856c7220f060cd113329e62f@kernel.crashing.org>
	<20070323031956.GB28006@localhost.localdomain>
	<1f513f9b14cfe469ffee3d8e10901776@kernel.crashing.org>
	<20070323235900.GH4459@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a2abd81a733627255520245bb35d26be@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 06/17] Document the linux,network-index property.
Date: Sat, 24 Mar 2007 01:23:59 +0100
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

>> Well it still needs to know property encoding...
>
> Well, yes, but in the most likely fixup cases that's trivial:
> clock-frequency properties are u32, memory address/size are u32 or
> u64, mac addresses are char[6].

Nit: what you call u64 actually is u32[2].  Alignment
matters sometimes.

>> It would be interesting to see if anyone actually uses this
>> feature ;-)
>
> Yes, it will.
>
> Oh, I have been planning for ages to make it possible (if less
> convenient) to use this with dtb as well as asm output, by
> (optionally) generating a "map file" (possibly in the form of a .h
> with #defines) alongside the dtb, giving the offsets of all the
> labels.

Sounds like overengineering to me but feel free to prove
me wrong :-)


Segher
