Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A88F4DDFF9
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 16:30:09 +1000 (EST)
Subject: Re: powerpc.git merge status
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080715113943.GA28229@polina.dev.rtsoft.ru>
References: <1216101729.7740.84.camel@pasglop>
	<20080715113943.GA28229@polina.dev.rtsoft.ru>
Content-Type: text/plain
Date: Thu, 17 Jul 2008 16:30:03 +1000
Message-Id: <1216276203.7740.306.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-15 at 15:39 +0400, Anton Vorontsov wrote:
> On Tue, Jul 15, 2008 at 04:02:09PM +1000, Benjamin Herrenschmidt wrote:
> [...]
> > If you believe I've missed something, now is time to be vocal about
> > it :-)
> 
> Yes, this one is lost:
> 
> [OF] of_gpio: should use new <linux/gpio.h> header
> http://patchwork.ozlabs.org/linuxppc/patch?id=18750

Is that supposed to go via the powerpc tree or is there a GPIO tree ? Is
there a GPIO maintainer that should ack it first ?

I know it's a trivial patch but I don't want to start maintainer clashes
right away :-)

Cheers,
Ben.
