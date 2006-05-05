Return-Path: <SRS0+4a93b1d90320a7f59990+985+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A20E7679EF
	for <linuxppc-dev@ozlabs.org>; Fri,  5 May 2006 10:34:01 +1000 (EST)
Subject: Re: Flash map information in device tree.
From: David Woodhouse <dwmw2@infradead.org>
To: Josh Boyer <jwboyer@jdub.homelinux.org>
In-Reply-To: <1146787262.12254.5.camel@vader.jdub.homelinux.org>
References: <1146785683.2885.148.camel@hades.cambridge.redhat.com>
	<1146787262.12254.5.camel@vader.jdub.homelinux.org>
Content-Type: text/plain
Date: Fri, 05 May 2006 01:33:48 +0100
Message-Id: <1146789228.17133.4.camel@shinybook.infradead.org>
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

On Thu, 2006-05-04 at 19:01 -0500, Josh Boyer wrote:
> On Fri, 2006-05-05 at 00:34 +0100, David Woodhouse wrote:
> > I'd like to get rid of some of the 'map' drivers in drivers/mtd/maps/
> > and replace them with simple platform devices. On PPC, I'd like to do
> > that with nodes in the device tree, with appropriate properties:
> > 	- physical address
> > 	- size
> > 	- bankwidth
> > 	- chip probe type (CFI/JEDEC/RAM/ROM/etc)
> 
> Hm.  How do you deal with NAND, which really isn't any of the above and
> can really depend on things like controllers, etc.
> 
> Or was this only for NOR for the time being?

Only NOR. NAND requires a little more than just "where is it?".

-- 
dwmw2
