Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6842DDE0E3
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 17:51:16 +1000 (EST)
Subject: Re: sfx.c driver build failure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Brown <mbrown@fensystems.co.uk>
In-Reply-To: <Pine.LNX.4.62.0807250831440.8217@dolphin.home>
References: <1216966559.11188.85.camel@pasglop>
	<Pine.LNX.4.62.0807250831440.8217@dolphin.home>
Content-Type: text/plain; charset=utf-8
Date: Fri, 25 Jul 2008 17:50:57 +1000
Message-Id: <1216972257.11188.96.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-07-25 at 08:35 +0100, Michael Brown wrote:
> On Fri, 25 Jul 2008, Benjamin Herrenschmidt wrote:
> > The sfx driver (which happens to be part of some of our test configs) 
> > fails to build in current Linus tree on powerpc with this error:
> > 
> > /home/benh/kernels/linux-powerpc/drivers/net/sfc/efx.c: In function ÿÿefx_probe_interruptsÿÿ:
> > /home/benh/kernels/linux-powerpc/drivers/net/sfc/efx.c:845: error: lvalue required as unary ÿÿ&ÿÿ oper
> > and
> 
> I'm not the maintainer of that code; I wrote the original version, but 
> it's now maintained by Solarflare.
> 
> I don't see anything on that line that ought to be architecture-specific.  
> Could you send me the preprocessed efx.c from your powerpc build?

Apparently, it's a know generic breakage of the topology stuff,
it's beeing sorted out.

Cheers,
Ben.
