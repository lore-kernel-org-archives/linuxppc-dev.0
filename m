Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 26F42679F2
	for <linuxppc-dev@ozlabs.org>; Wed,  4 May 2005 09:43:48 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ian Wienand <ianw@gelato.unsw.edu.au>
In-Reply-To: <20050503222200.GA29940@cse.unsw.EDU.AU>
References: <1115072133.6031.33.camel@gaston>
	<20050503222200.GA29940@cse.unsw.EDU.AU>
Content-Type: text/plain
Date: Wed, 04 May 2005 09:41:30 +1000
Message-Id: <1115163690.7568.45.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	DebianPPC <debian-powerpc@lists.debian.org>
Subject: Re: Laptop sleep & current "git" tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-05-04 at 08:22 +1000, Ian Wienand wrote:
> On Tue, May 03, 2005 at 08:15:33AM +1000, Benjamin Herrenschmidt wrote:
> > I would appreciate extensive testing, provided you figure out how to
> > retreive the "git" repository from kernel.org :) There must be some
> > howto somewhere, but I'm afraid I don't have a link at hand.
> 
> It's so far working well for me on an 800Mhz iBook (750fx) after quite
> a few sleep and resume cycles.
> 
> Is there a fix in the works for the Radeon timing thing that makes the
> screen go a little weird on wakeup?

I don't know this problem, what happens precisely and what model of
radeon chip do you have ?

> FWIW, the two step way to get the git tree I followed was
> 
> wget http://www.kernel.org/pub/software/scm/cogito/cogito-0.8.tar.bz2
> (install, modify path in Makefile if you want)
> 
> cd /usr/src
> mkdir linux-2.6-git
> cd linux-2.6-git
> cg-init rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> 
> -i
> ianw@gelato.unsw.edu.au
> http://www.gelato.unsw.edu.au
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
