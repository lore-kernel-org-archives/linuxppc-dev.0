Return-Path: <torvalds@linux-foundation.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.24])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E8CDDDDEDD
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Mar 2007 06:55:22 +1000 (EST)
Date: Wed, 28 Mar 2007 13:55:10 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: fix dcr_unmap()
In-Reply-To: <1175085776.32220.9.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0703281354220.6730@woody.linux-foundation.org>
References: <200703281207.41425.jdubois@mc.com>
	<1175085776.32220.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Wed, 28 Mar 2007, Benjamin Herrenschmidt wrote:

> On Wed, 2007-03-28 at 11:07 +0100, Jean-Christophe Dubois wrote:
> > Fix a bug in dcr_unmap(). 
> > 
> > At unmap time the DCR offset need to be added instead of substracted.
> > 
> > Signed-off-by: Jean-Christophe Dubois <jdubois@mc.com>
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> If possible that should go in 2.6.21

Can I get an original patch email and/or a git pull request? I didn't see 
the original email, since I'm not on the linuxppc list..

		Linus
