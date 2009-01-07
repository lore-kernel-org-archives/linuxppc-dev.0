Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0D184DE0A0
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 08:13:33 +1100 (EST)
Subject: Re: Building current git for 405 is broken
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
In-Reply-To: <200901071510.45923.matthias.fuchs@esd-electronics.com>
References: <200901071510.45923.matthias.fuchs@esd-electronics.com>
Content-Type: text/plain
Date: Thu, 08 Jan 2009 08:13:09 +1100
Message-Id: <1231362789.2142.23.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-01-07 at 15:10 +0100, Matthias Fuchs wrote:
> Hi Benjamin,
> 
> commit 2a4aca114439 (powerpc/mm: Split low level tlb invalidate for nohash processors)
> breaks building for 40x CPUs. This is what I get when building for the walnut board:

The fix is in my tree, I'll push it out and ask Linus to pull later
today or tomorrow.

Cheers,
Ben.
