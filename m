Return-Path: <q-funk@pp.fishpool.fi>
Received: from hal.pp.fishpool.fi (hal.fishpool.fi [213.157.66.81])
	by ozlabs.org (Postfix) with ESMTP id 79E6F67B40
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Apr 2005 20:36:34 +1000 (EST)
Date: Sat, 9 Apr 2005 13:12:31 +0300 (EEST)
From: =?iso-8859-1?Q?Martin-=C9ric_Racine?= <q-funk@iki.fi>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1113006674.9568.414.camel@gaston>
Message-ID: <Pine.LNX.4.21.0504091309420.18767-100000@hal.pp.fishpool.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Sender: Martin-Eric Racine <q-funk@pp.fishpool.fi>
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

On Sat, 9 Apr 2005, Benjamin Herrenschmidt wrote:

> If you have a newer machine, that is a machine released on or after
> 2002, can you please send me the output of:

[...]

> I'm especially interested in the various models of G5 based machines. It
> seems apple is having all sorts of very different sound HW setups on
> those machines, and I'm trying to figure out exactly what is where based
> on those infos and the darwin sources.

Why limit this to new hardware, though?  Why not modularize the pmac ALSA
tree and completely fix all previous hardware variants as well?

Btw, not sound-related but nonetheless a bug in the device tree:

/proc/device-tree/psuedo-hid

That wouldn't be a typo now, would it?

--=20
Martin-=C9ric Racine
http://www.iki.fi/q-funk/
