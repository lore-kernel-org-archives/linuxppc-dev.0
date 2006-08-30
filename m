Return-Path: <marcus@mc.pp.se>
Received: from omoikane.mc.pp.se (ua-85-227-1-9.cust.bredbandsbolaget.se
	[85.227.1.9]) by ozlabs.org (Postfix) with ESMTP id AA202679E0
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 03:43:10 +1000 (EST)
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] EHCI Oops on CONFIG_NOT_COHERENT_CACHE system
References: <9mz9np82b.fsf@omoikane.mc.pp.se>
	<3e3f83654b861ae77c6c07cf207ba6af@bga.com>
From: Marcus Comstedt <marcus@mc.pp.se>
Date: Wed, 30 Aug 2006 19:42:31 +0200
In-Reply-To: <3e3f83654b861ae77c6c07cf207ba6af@bga.com> (Milton Miller's
	message of "Wed, 30 Aug 2006 09:24:57 -0500")
Message-ID: <yf9veoa6ry0.fsf@omoikane.mc.pp.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Milton Miller <miltonm@bga.com> writes:

> I think its a case of the people that know the architecture agree
> that atomics and DMA do not mix, and that this is an issue for
> usb-devel to fix.

That was precisely the kind of agreement I was looking for.  :-)


> The other question is: does the current access polute the cache by
> reading things where the device is supposed to be writing?

Well, that shouldn't be an issue as the page is cache-inhibited.
And on systems with cache coherency, where the pages are not cache-
inhibited, this would be handled by bus snooping, right?


> My suggestion is take the issue over there, and only cc us here if
> you get pushback over there.

Ok, will do.  Thanks.


  // Marcus
