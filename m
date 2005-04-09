Return-Path: <paubert@iram.es>
Received: from gra-vd1.iram.es (gra-vd1.iram.es [150.214.224.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C469967B2E
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Apr 2005 08:06:40 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Sun, 10 Apr 2005 00:06:19 +0200
To: =?iso-8859-1?Q?Martin-=C9ric?= Racine <q-funk@iki.fi>
Message-ID: <20050409220619.GA4354@iram.es>
References: <1113006674.9568.414.camel@gaston>
	<Pine.LNX.4.21.0504091309420.18767-100000@hal.pp.fishpool.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <Pine.LNX.4.21.0504091309420.18767-100000@hal.pp.fishpool.fi>
Cc: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: Sound drivers for newer machines: need help
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 09, 2005 at 01:12:31PM +0300, Martin-Éric Racine wrote:
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
> 
> Btw, not sound-related but nonetheless a bug in the device tree:
> 
> /proc/device-tree/psuedo-hid
> 
> That wouldn't be a typo now, would it?

It is a typo by Apple. It is the name in the firmware of my
PowerMacG4 466 (PowerMac3,4) under the OF prompt too 
(psuedo-hid and psuedo-sound). 

OTOH in my Pismo (PowerBook3,1) these same name are spelled 
correctly, despite the fact that it is older (but it has had 
at least one firmware upgrade while the G4 has none AFAIR).

/proc/device-tree keeps the names given by OF and only adds 
a few of its own, "linux,phandle" mostly.

	Gabriel
