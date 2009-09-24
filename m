Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 59F05B7B7B
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 09:53:03 +1000 (EST)
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache
	coherency rewrite
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rex Feany <RFeany@mrv.com>
In-Reply-To: <20090924233346.GA445@compile2.chatsunix.int.mrv.com>
References: <20090924004552.GA11737@compile2.chatsunix.int.mrv.com>
	<1253774659.7103.405.camel@pasglop>
	<20090924233346.GA445@compile2.chatsunix.int.mrv.com>
Content-Type: text/plain
Date: Fri, 25 Sep 2009 09:52:56 +1000
Message-Id: <1253836376.7103.469.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-09-24 at 16:33 -0700, Rex Feany wrote:
> Thus spake Benjamin Herrenschmidt (benh@kernel.crashing.org):
> 
> > You can get my tree at:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git
> > 
> > (To get the "merge" branch, just add "merge" after the clone if you
> > are cloning it, or just create a local branch and manually pull
> > into it)
> 
> Your tree hangs on boot, similar to what I saw without the 8xx
> work-around patch -- it is hard to tell if it is the same though. :(

There's no backtrace ? Where does it hang ? Also which workaround
patch ? The missing tlbil_va() or the _PAGE_SPECIAL problem ?

> > Note that i just pushed out so it may take a little while for
> > the kernel.org mirrors to get it, the commit ID is: 
> > 
> > ae48e383e3299c2f87723d21df2db97927774b1e
> 
> Maybe I fail git 101 -- I can't seem to find that commit ID in the repo
> above, but I do see the patches you commited to fix PAGE_SPECIAL and the
> 8xx work-around.

Right. I must have screwed something with the ID.

Ben.
