Return-Path: <RFeany@mrv.com>
Received: from bos-spam.mrv.com (mx5.mrv.com [140.179.254.12])
	by ozlabs.org (Postfix) with ESMTP id AD528B7B77
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 09:33:49 +1000 (EST)
Date: Thu, 24 Sep 2009 16:33:46 -0700
From: Rex Feany <RFeany@mrv.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache
	coherency rewrite
Message-ID: <20090924233346.GA445@compile2.chatsunix.int.mrv.com>
References: <20090924004552.GA11737@compile2.chatsunix.int.mrv.com>
	<1253774659.7103.405.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1253774659.7103.405.camel@pasglop>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thus spake Benjamin Herrenschmidt (benh@kernel.crashing.org):

> You can get my tree at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git
> 
> (To get the "merge" branch, just add "merge" after the clone if you
> are cloning it, or just create a local branch and manually pull
> into it)

Your tree hangs on boot, similar to what I saw without the 8xx
work-around patch -- it is hard to tell if it is the same though. :(

> Note that i just pushed out so it may take a little while for
> the kernel.org mirrors to get it, the commit ID is: 
> 
> ae48e383e3299c2f87723d21df2db97927774b1e

Maybe I fail git 101 -- I can't seem to find that commit ID in the repo
above, but I do see the patches you commited to fix PAGE_SPECIAL and the
8xx work-around.

thanks!
/rex.
