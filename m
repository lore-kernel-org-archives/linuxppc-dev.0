Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (71-214-132-244.roch.qwest.net
	[71.214.132.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 79E04679E1
	for <linuxppc-dev@ozlabs.org>; Fri,  5 May 2006 10:01:07 +1000 (EST)
Subject: Re: Flash map information in device tree.
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1146785683.2885.148.camel@hades.cambridge.redhat.com>
References: <1146785683.2885.148.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Date: Thu, 04 May 2006 19:01:02 -0500
Message-Id: <1146787262.12254.5.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-05-05 at 00:34 +0100, David Woodhouse wrote:
> I'd like to get rid of some of the 'map' drivers in drivers/mtd/maps/
> and replace them with simple platform devices. On PPC, I'd like to do
> that with nodes in the device tree, with appropriate properties:
> 	- physical address
> 	- size
> 	- bankwidth
> 	- chip probe type (CFI/JEDEC/RAM/ROM/etc)

Hm.  How do you deal with NAND, which really isn't any of the above and
can really depend on things like controllers, etc.

Or was this only for NOR for the time being?

> 	- partitioning information
> 
> Can we define a format for this so it can be included in the device
> trees which we're presumably going to be generating for the embedded
> boards which are supported by the arch/powerpc kernel?

Platform drivers in general would be a good starting point I think.
Then you can transition those to using the generated flat device tree,
right?

> 
> If we can get either an updated u-boot or a boot wrapper which work on
> the Wind River SBC8265 or SBC8560 boards, I might even be able to test
> it myself.

Or if anyone is ambitions and wants to get things working on a bamboo
board... :)

josh
