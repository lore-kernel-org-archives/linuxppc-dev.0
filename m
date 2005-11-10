Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8406968706
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2005 17:08:42 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20051109220022.264437f8.akpm@osdl.org>
References: <20051109072228.GA7983@pb15.lixom.net>
	<1131526855.24637.67.camel@gaston>
	<20051109213837.47c8dce7.akpm@osdl.org>
	<1131601224.24637.155.camel@gaston>
	<20051109220022.264437f8.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 17:06:33 +1100
Message-Id: <1131602793.24637.159.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc: add support for new powerbooks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Well yes, that's a generic problem with subsystem trees.  I suppose one
> could enforce processes which prevent it from happening.

I think the right process is to go through the linuxppc[64]-dev list(s)
first, maybe CC lkml when it's not strictly arch gore, and then hop from
there to -git. We also have a nice patch tracking system scanning those
lists, I suppose I need to fix my own habits of bypassing all of that
stuff :)

> OK, well please think about it.  It's not a ton of work at this end at
> present, but a) you lazy bums don't ack most of the things I cc you on, so
> it's rather open-loop and I don't know whether I'm merging wrong patches
> and b) there's now increasing potential for patches in -mm to clash with
> patches in Paul's git tree.
> 
> The latter can be solved easily enough: I add Paul's git tree to the -mm
> lineup.

I think going through the -git tree always makes sense and I've doing
doing that for my own production, I'll route patches that I'm acking
that way too from now on.

I'm keeping the liberty of bombing you & linus directly when I think
it's an important bug fix late in the rc cycle though :)

Ben.
