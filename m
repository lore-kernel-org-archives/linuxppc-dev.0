Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B8748DDFA2
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 13:00:39 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix demotion of segments to 4K pages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20071029015014.GA13687@lixom.net>
References: <1193619918.9928.0.camel@pasglop>
	<20071029015014.GA13687@lixom.net>
Content-Type: text/plain
Date: Mon, 29 Oct 2007 13:00:29 +1100
Message-Id: <1193623229.9928.2.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2007-10-28 at 20:50 -0500, Olof Johansson wrote:
> Hi Ben,
> 
> On Mon, Oct 29, 2007 at 12:05:18PM +1100, Benjamin Herrenschmidt wrote:
> > @@ -887,6 +886,9 @@ void hash_preload(struct mm_struct *mm, 
> >  	local_irq_restore(flags);
> >  }
> >  
> > +/* WARNING: This is called from hash_low_64.S, if you change this prototype,
> > + *          do not forget to update the assembly call site !
> > + */
> 
> Since we're already policing whitespace on this list today: We're normally
> not using spaces before exclamation marks.

And I don't care, I will continue adding them because the opposite is
fugly :-)

There is a limit to what I accept from the style police, it's not like
Linux has to look like it's written by a single person either.

Ben.
 
