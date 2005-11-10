Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 69B4C686F9
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2005 16:42:30 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20051109213837.47c8dce7.akpm@osdl.org>
References: <20051109072228.GA7983@pb15.lixom.net>
	<1131526855.24637.67.camel@gaston>
	<20051109213837.47c8dce7.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 16:40:24 +1100
Message-Id: <1131601224.24637.155.camel@gaston>
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


> I don't think I'm adding much value handling ppc/ppc64 patches, really. 
> I'd prefer to get out of that business.
> 
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

Well, I'm personally no fan of the git route as it causes us to have
less review on the list imho (too easy also for me to just bounce a
patch to paulus to shove in his git tree :) though that's what I've been
doing for the last few days at least. But if you prefer that way, yes,
it's certainly possible.

Ben.
