Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D937B67B2A
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Apr 2005 09:28:57 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?Martin-=C9ric?= Racine <q-funk@iki.fi>
In-Reply-To: <Pine.LNX.4.21.0504091309420.18767-100000@hal.pp.fishpool.fi>
References: <Pine.LNX.4.21.0504091309420.18767-100000@hal.pp.fishpool.fi>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sun, 10 Apr 2005 09:27:12 +1000
Message-Id: <1113089232.9568.434.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: Sound drivers for newer machines: need help
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2005-04-09 at 13:12 +0300, Martin-Éric Racine wrote:
> On Sat, 9 Apr 2005, Benjamin Herrenschmidt wrote:
> 
> > If you have a newer machine, that is a machine released on or after
> > 2002, can you please send me the output of:
> 
> [...]
> 
> > I'm especially interested in the various models of G5 based machines. It
> > seems apple is having all sorts of very different sound HW setups on
> > those machines, and I'm trying to figure out exactly what is where based
> > on those infos and the darwin sources.
> 
> Why limit this to new hardware, though?  Why not modularize the pmac ALSA
> tree and completely fix all previous hardware variants as well?

Which is what I am doing, I just need some more infos about new hardware
because the HW setup done by Apple on those is fairly confusing.
 
> Btw, not sound-related but nonetheless a bug in the device tree:
> 
> /proc/device-tree/psuedo-hid
> 
> That wouldn't be a typo now, would it?

Might be but nobody cares about this one anyway.

Ben.
