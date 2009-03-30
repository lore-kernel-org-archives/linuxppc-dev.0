Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D482CDDE9F
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 10:19:06 +1100 (EST)
Subject: Re: Build error
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20090330135903.GA11614@oksana.dev.rtsoft.ru>
References: <1238383506.17330.0.camel@pasglop>
	<7E26E694-85F8-445F-9113-88DCD61BC32C@kernel.crashing.org>
	<20090330135903.GA11614@oksana.dev.rtsoft.ru>
Content-Type: text/plain
Date: Tue, 31 Mar 2009 10:18:56 +1100
Message-Id: <1238455136.17330.12.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-03-30 at 17:59 +0400, Anton Vorontsov wrote:
> On Mon, Mar 30, 2009 at 08:51:38AM -0500, Kumar Gala wrote:
> >
> > On Mar 29, 2009, at 10:25 PM, Benjamin Herrenschmidt wrote:
> >
> >> My next branch (after merging from you):
> >>
> >> ERROR: "fsl_pq_mdio_bus_name" [drivers/net/gianfar_driver.ko]  
> >> undefined!
> >>
> >> I'll ask Linus to pull anyway though.
> >>
> >> Cheers,
> >> Ben.
> >
> > I believe this is fixed in net-next (and possible linus has already  
> > pulled that in.)
> 
> FWIW, I can't reproduce the issue neither in benh/powerpc.git `next'
> branch nor in `merge' branch...

Ah .. .weird :-)

Oh well, I'll see if it still happens after I pull back from Linus (who
merged all our stuff) and if it does, I'll send you my .config.

Cheers,
Ben.
