Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 278D9686E9
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2005 16:38:53 +1100 (EST)
Date: Wed, 9 Nov 2005 21:38:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <20051109213837.47c8dce7.akpm@osdl.org>
In-Reply-To: <1131526855.24637.67.camel@gaston>
References: <20051109072228.GA7983@pb15.lixom.net>
	<1131526855.24637.67.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

I don't think I'm adding much value handling ppc/ppc64 patches, really. 
I'd prefer to get out of that business.

It would be better to have an arch maintainer who runs a git tree, same as
ia64, arm, etc.

And, given the amount of shared infrastructure, I suspect it would have to
be a single git tree for both architectures.

I'd still sweep up random ppc patches, but those will go into mainline via the
originator->mm->git-powerpc->linus route.

Possible?
