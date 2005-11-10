Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6C42F686AD
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2005 17:30:02 +1100 (EST)
Date: Wed, 9 Nov 2005 22:29:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Message-Id: <20051109222945.5b721c56.akpm@osdl.org>
In-Reply-To: <17266.58346.798470.79283@cargo.ozlabs.ibm.com>
References: <20051109072228.GA7983@pb15.lixom.net>
	<1131526855.24637.67.camel@gaston>
	<20051109213837.47c8dce7.akpm@osdl.org>
	<17266.58346.798470.79283@cargo.ozlabs.ibm.com>
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

Paul Mackerras <paulus@samba.org> wrote:
>
> > And, given the amount of shared infrastructure, I suspect it would have to
> > be a single git tree for both architectures.
> > 
> > I'd still sweep up random ppc patches, but those will go into mainline via the
> > originator->mm->git-powerpc->linus route.
> > 
> > Possible?
> 
> Yes.  Good idea, in fact.  I'll create a powerpc.git tree once the
> current merge window closes.

OK.

> Do I need to grep the -mm releases for ppc patches or will you mail
> them to me?

If I see a ppc patch I will:

- merge it into -mm, add you guys to the cc on the mm-commits email.

- stage the patch after git-powerpc.patch in the -mm lineup.

- if I see the patch appear in git-powerpc.patch, I just drop it.  I sync
  with the git trees maybe twice per day.

- time passes

- if it still hasn't been merged into git-powerpc, I start spamming you
  with the patch.

So no, you don't need to grep -mm and I won't bypass the git-powerpc tree
and the patch won't get lost.  All you need to do is to either merge or
nack the patch at some stage.

Easy as pie ;)
