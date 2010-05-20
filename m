Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AA2E9B7D4A
	for <linuxppc-dev@ozlabs.org>; Thu, 20 May 2010 10:24:02 +1000 (EST)
Subject: Re: [PATCH] powerpc: make the padding for the device tree a
	configurable option
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <AANLkTilefxXcMnWqKSultu88r4D9W98adHLHxvUwi113@mail.gmail.com>
References: <1274298809-12772-1-git-send-email-timur@freescale.com>
	<1274304013.1931.6.camel@pasglop> <4BF4593E.8030101@freescale.com>
	<1274309050.1931.21.camel@pasglop>
	<AANLkTilefxXcMnWqKSultu88r4D9W98adHLHxvUwi113@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 20 May 2010 10:23:53 +1000
Message-ID: <1274315033.1931.25.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-05-19 at 19:03 -0500, Timur Tabi wrote:
> The problem is that the code which allocates a block for the fdt is
> completely distinct from the code that manipulates the fdt.  We'd need
> to put in either some kind of funky callback mechanism, or insist that
> every fdt exist in a block of memory allocated by some specific method
> (e.g. lmb).
> 
> I'm stuck between a rock and a hard place, it seems.  No one is
> willing to compromise on any of my ideas.  It's hard to convince our
> BSP developers that they should be pushing more code upstream when I
> get so much resistance for a such a mundane change. 

I don't see why we couldn't add a callback to libfdt for allocation /
reallocation.

Cheers,
Ben.
