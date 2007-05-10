Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[65.172.181.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.osdl.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 92A74DDF0F
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 18:50:44 +1000 (EST)
Date: Thu, 10 May 2007 01:50:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/3] Add hard_irq_disable()
Message-Id: <20070510015036.ebded3ac.akpm@linux-foundation.org>
In-Reply-To: <1178786505.14928.225.camel@localhost.localdomain>
References: <20070510052622.3E8D5DDF4B@ozlabs.org>
	<20070509224113.cca81a24.akpm@linux-foundation.org>
	<1178778951.14928.215.camel@localhost.localdomain>
	<20070510003528.395b122b.akpm@linux-foundation.org>
	<1178786505.14928.225.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 10 May 2007 18:41:45 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > > What about my comment layout style ? I've been using that forever ... Or
> > > do you mean I should use a function documentation style layout there ?
> > 
> > /* This
> >  * is
> >  * wrong
> >  */
> > 
> > /*
> >  * This
> >  * is
> >  * right
> >  */
> 
> Hrm... how bad are you about that one ? I must say I prefer my style :-)
> 

I usually shrug and ignore it.  It's more a matter of informing people
about it than going in there and fixing them all.

We discussed this a couple of months back.  davem landed firmly in the
second camp and everyone then shut up ;)
