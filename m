Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6B285DDE09
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Aug 2007 07:32:02 +1000 (EST)
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: 8250.c::autoconfig() fails loopback test on MPC824[15] 
In-Reply-To: Your message of "Sun, 05 Aug 2007 18:41:16 +0200."
	<200708051841.17471.arnd@arndb.de>
References: <Pine.LNX.4.60.0708050106270.4299@poirot.grange>
	<200708050135.07753.arnd@arndb.de>
	<Pine.LNX.4.60.0708051600550.4120@poirot.grange>
	<200708051841.17471.arnd@arndb.de>
Date: Sun, 05 Aug 2007 16:31:52 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IHnhY-0008PO-IZ@jdl.com>
Cc: linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Arnd Bergmann mumbled:
> On Sunday 05 August 2007, Guennadi Liakhovetski wrote:
> > That would be a possibility, but that would mean all 8241/8245 have to 
> > adjust their .dts. Ok, there are not so many of them in the mainline now 
> > (in fact, hardly any apart from linkstation:-)), still. Cannot we use 

Heck, I'm slowly working on the StorCenter too.. :-)

I supect it will have the same issue in the end, right?

jdl
