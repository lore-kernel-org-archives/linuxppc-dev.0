Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C36F5DDDF8
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Mar 2007 08:24:44 +1000 (EST)
Subject: Re: [PATCH] powerpc: fix dcr_unmap()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0703281354220.6730@woody.linux-foundation.org>
References: <200703281207.41425.jdubois@mc.com>
	<1175085776.32220.9.camel@localhost.localdomain>
	<Pine.LNX.4.64.0703281354220.6730@woody.linux-foundation.org>
Content-Type: text/plain
Date: Thu, 29 Mar 2007 08:24:32 +1000
Message-Id: <1175120672.32220.13.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-03-28 at 13:55 -0700, Linus Torvalds wrote:
> 
> On Wed, 28 Mar 2007, Benjamin Herrenschmidt wrote:
> 
> > On Wed, 2007-03-28 at 11:07 +0100, Jean-Christophe Dubois wrote:
> > > Fix a bug in dcr_unmap(). 
> > > 
> > > At unmap time the DCR offset need to be added instead of substracted.
> > > 
> > > Signed-off-by: Jean-Christophe Dubois <jdubois@mc.com>
> > 
> > Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> > 
> > If possible that should go in 2.6.21
> 
> Can I get an original patch email and/or a git pull request? I didn't see 
> the original email, since I'm not on the linuxppc list..

Sorry about that, I'll bounce it to you
