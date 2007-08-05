Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DF911DDE0F
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Aug 2007 07:50:34 +1000 (EST)
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: 8250.c::autoconfig() fails loopback test on MPC824[15] 
In-Reply-To: Your message of "Sun, 05 Aug 2007 23:39:19 +0200."
	<Pine.LNX.4.60.0708052336360.4120@poirot.grange>
References: <Pine.LNX.4.60.0708050106270.4299@poirot.grange>
	<200708050135.07753.arnd@arndb.de>
	<Pine.LNX.4.60.0708051600550.4120@poirot.grange>
	<200708051841.17471.arnd@arndb.de> <E1IHnhY-0008PO-IZ@jdl.com>
	<Pine.LNX.4.60.0708052336360.4120@poirot.grange>
Date: Sun, 05 Aug 2007 16:50:29 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IHnzZ-0008SZ-2y@jdl.com>
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Guennadi Liakhovetski mumbled:
> On Sun, 5 Aug 2007, Jon Loeliger wrote:
> 
> ...if you choose to use of_serial.c, yes, if you don't use it and just use 
> legacy_serial.c, then you're fine.

Ah, I see.  OK.

> BTW, my offer still holds to see if we can build a single kernel for both 
> with just specific device-trees, but that's a separate matter:-)

Indeed.  I'm fully on-board with that goal, but it may take a couple
rounds to refine it into that state.

One question I have is the stupid ethernet driver.  Is the driver
that is in mainline now usable on the StorCenter?  I haven't
waded through the supplied vendor patch to verify how it compares
to the r8169 in mainline yet.

Also, what do you want to do about the Kconfig set up for these then?
Specifically, do you want to have "TurboStation" and "StorCenter"?
Or would it make more sense to have something like a generic
"NAS8241" with sub-choices of "storcenter" and "turbostation"?

Thanks,
jdl
