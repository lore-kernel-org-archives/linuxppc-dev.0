Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id DE03C68705
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2005 03:44:39 +1100 (EST)
Date: Thu, 10 Nov 2005 08:44:04 -0800
To: Andrew Morton <akpm@osdl.org>
Message-ID: <20051110164404.GA7303@pb15.lixom.net>
References: <20051109072228.GA7983@pb15.lixom.net>
	<1131526855.24637.67.camel@gaston>
	<20051109213837.47c8dce7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051109213837.47c8dce7.akpm@osdl.org>
From: Olof Johansson <olof@lixom.net>
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

On Wed, Nov 09, 2005 at 09:38:37PM -0800, Andrew Morton wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> I don't think I'm adding much value handling ppc/ppc64 patches, really. 
> I'd prefer to get out of that business.

Main benefit for me, as a patch submitter, is that you consistently,
always, ACK when you pick up or drop a patch. In other words, I don't
have to go polling a tree to see if it made it in or not.

> It would be better to have an arch maintainer who runs a git tree, same as
> ia64, arm, etc.
> 
> And, given the amount of shared infrastructure, I suspect it would have to
> be a single git tree for both architectures.
> 
> I'd still sweep up random ppc patches, but those will go into mainline via the
> originator->mm->git-powerpc->linus route.
> 
> Possible?

I'm fine with all that; to be honest I haven't been certain where the
smaller ppc/ppc64 patches should go during this whole merge business (or
after, for that matter).

If Paulus wants to start an arch tree, that's fine with me. I do share
Ben's opinion about less review though, I guess we'll just have to deal
with that.

Also, Paul, I kindly request some sort of ACK mechanism similar to
Andrew's when patches are picked up. :-)


Thanks,

-Olof
