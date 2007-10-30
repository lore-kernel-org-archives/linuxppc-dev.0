Return-Path: <Sergej.Stepanov@ids.de>
Received: from ares.ids.de (ares.ids.de [213.144.29.131])
	by ozlabs.org (Postfix) with ESMTP id 18CE1DE311
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 03:58:39 +1100 (EST)
Received: from ares.ids.de (ares.ids.de [127.0.0.1])
	by ares.ids.de (PGP Universal) with ESMTP id EE3B2F490E8
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 17:58:37 +0100 (CET)
Subject: Re: [PATCH] using mii-bitbang on different processor ports
From: Sergej Stepanov <Sergej.Stepanov@ids.de>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <20071030163200.GA4470@loki.buserror.net>
References: <1193760559.6244.25.camel@p60635-ste.ids.de>
	<20071030163200.GA4470@loki.buserror.net>
Date: Tue, 30 Oct 2007 17:58:37 +0100
Message-Id: <1193763517.6244.33.camel@p60635-ste.ids.de>
Mime-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Scott.
Thank you for reply.
Am Dienstag, den 30.10.2007, 11:32 -0500 schrieb Scott Wood:
> On Tue, Oct 30, 2007 at 05:09:19PM +0100, Sergej Stepanov wrote:

> You could just use of_iomap() for the second one, since we don't need
> the physical address for bus->id.
Nice tip.
Than it would be needless-------
				|
				\/
> > +			iounmap(bitbang->mdc.dir);
> > +			return -ENOMEM;
> 
> Please use the goto-style error handling that's used elsewhere in the
> function.
Regards
Sergej.
 
