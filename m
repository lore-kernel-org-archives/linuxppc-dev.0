Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 74E6B2BDB5
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2004 08:57:12 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Frank Murphy <murphyf+xfree86@f-m.fm>
In-Reply-To: <1101721355.31317.209633721@webmail.messagingengine.com>
References: <200411232008.16854.murphyf+xfree86@f-m.fm>
	<200411270948.08054.murphyf+xfree86@f-m.fm>
	<1101607094.5176.0.camel@gaston>
	<200411282114.48141.murphyf+xfree86@f-m.fm>
	<1101674379.4653.9.camel@gaston>
	<1101721355.31317.209633721@webmail.messagingengine.com>
Content-Type: text/plain
Date: Tue, 30 Nov 2004 08:56:49 +1100
Message-Id: <1101765409.15462.3.camel@gaston>
Mime-Version: 1.0
Cc: debian-x@lists.debian.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: G3 iBook LCD brightness in X under kernel 2.4.25 and 2.6.8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2004-11-29 at 10:42 +0100, Frank Murphy wrote:

> It probably is. But it's strange because I use all the same software
> except the kernel to get this behavior. So there's something with the
> kernel / X interface that has changed, either for 2.6 or the way Debian
> builds 2.6. I have a hard time with this because there are so many
> interactions:  is it the PMU? The APM emulation? X driver? Kernel
> driver? I don't have a good idea about how these things interact.
> 
> Let me know what you find out.

It has to do with interactions between the X driver and the atyfb driver
I suppose...

Ben.
