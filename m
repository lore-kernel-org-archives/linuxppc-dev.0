Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17266.58346.798470.79283@cargo.ozlabs.ibm.com>
Date: Thu, 10 Nov 2005 17:08:42 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20051109213837.47c8dce7.akpm@osdl.org>
References: <20051109072228.GA7983@pb15.lixom.net>
	<1131526855.24637.67.camel@gaston>
	<20051109213837.47c8dce7.akpm@osdl.org>
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

Andrew Morton writes:

> I don't think I'm adding much value handling ppc/ppc64 patches, really. 
> I'd prefer to get out of that business.
> 
> It would be better to have an arch maintainer who runs a git tree, same as
> ia64, arm, etc.

My powerpc-merge.git tree is sort-of de-facto that at the moment.

> And, given the amount of shared infrastructure, I suspect it would have to
> be a single git tree for both architectures.
> 
> I'd still sweep up random ppc patches, but those will go into mainline via the
> originator->mm->git-powerpc->linus route.
> 
> Possible?

Yes.  Good idea, in fact.  I'll create a powerpc.git tree once the
current merge window closes.

Do I need to grep the -mm releases for ppc patches or will you mail
them to me?

Regards,
Paul.
