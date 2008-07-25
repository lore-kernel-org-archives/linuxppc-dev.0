Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4F2FBDDDFF
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 14:04:35 +1000 (EST)
Subject: Re: [RFC] 4xx hardware watchpoint support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: luisgpm@linux.vnet.ibm.com
In-Reply-To: <1216829442.5727.97.camel@gargoyle>
References: <1211391577.6232.15.camel@gargoyle>
	<18484.60888.981390.893747@cargo.ozlabs.ibm.com>
	<1213992894.6635.41.camel@gargoyle>
	<20080719093752.5aada45c@zod.rchland.ibm.com>
	<1216658194.5727.36.camel@gargoyle>
	<20080721130551.23a06006@zod.rchland.ibm.com>
	<1216777678.5727.82.camel@gargoyle>
	<20080723115321.53aa655b@zod.rchland.ibm.com>
	<1216829442.5727.97.camel@gargoyle>
Content-Type: text/plain
Date: Fri, 25 Jul 2008 14:00:33 +1000
Message-Id: <1216958433.11188.70.camel@pasglop>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Christoph Hellwig <hch@lst.de>,
	Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-07-23 at 13:10 -0300, Luis Machado wrote:
> On Wed, 2008-07-23 at 11:53 -0400, Josh Boyer wrote:
> > Shouldn't this (and other places) be:
> > 
> > #if defined(CONFIG_44x) || defined(CONFIG_BOOKE)
> > 
> > if you are going to exclude 40x for now?  Otherwise this is still
> > enabled on 405 and setting the wrong register.
> > 
> > josh
> 
> Yes, sorry. I wasn't aware of this specific define value. It makes
> things easier to support 405's later.
> 
> Like so?

Please, next time, when you re-send a patch like that, re-include
the full subject and patch description. You can add then blurbs after
the --- line if you want to add things that won't make it to git.

I'll deal with that specific one for now.

Cheers,
Ben.
