Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 821EADDE16
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Aug 2007 07:39:11 +1000 (EST)
Date: Sun, 5 Aug 2007 23:39:19 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: 8250.c::autoconfig() fails loopback test on MPC824[15] 
In-Reply-To: <E1IHnhY-0008PO-IZ@jdl.com>
Message-ID: <Pine.LNX.4.60.0708052336360.4120@poirot.grange>
References: <Pine.LNX.4.60.0708050106270.4299@poirot.grange>
	<200708050135.07753.arnd@arndb.de>
	<Pine.LNX.4.60.0708051600550.4120@poirot.grange>
	<200708051841.17471.arnd@arndb.de>  <E1IHnhY-0008PO-IZ@jdl.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Sun, 5 Aug 2007, Jon Loeliger wrote:

> So, like, the other day Arnd Bergmann mumbled:
> > On Sunday 05 August 2007, Guennadi Liakhovetski wrote:
> > > That would be a possibility, but that would mean all 8241/8245 have to 
> > > adjust their .dts. Ok, there are not so many of them in the mainline now 
> > > (in fact, hardly any apart from linkstation:-)), still. Cannot we use 
> 
> Heck, I'm slowly working on the StorCenter too.. :-)
> 
> I supect it will have the same issue in the end, right?

...if you choose to use of_serial.c, yes, if you don't use it and just use 
legacy_serial.c, then you're fine.

BTW, my offer still holds to see if we can build a single kernel for both 
with just specific device-trees, but that's a separate matter:-)

Thanks
Guennadi
---
Guennadi Liakhovetski
