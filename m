Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 914A2DDFE8
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 13:58:51 +1100 (EST)
Date: Sun, 28 Oct 2007 22:06:48 -0500
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix demotion of segments to 4K pages
Message-ID: <20071029030648.GA14199@lixom.net>
References: <1193619918.9928.0.camel@pasglop>
	<20071029015014.GA13687@lixom.net>
	<1193623229.9928.2.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1193623229.9928.2.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 29, 2007 at 01:00:29PM +1100, Benjamin Herrenschmidt wrote:
 
> On Sun, 2007-10-28 at 20:50 -0500, Olof Johansson wrote:
> > Hi Ben,
> > 
> > On Mon, Oct 29, 2007 at 12:05:18PM +1100, Benjamin Herrenschmidt wrote:
> > > @@ -887,6 +886,9 @@ void hash_preload(struct mm_struct *mm, 
> > >  	local_irq_restore(flags);
> > >  }
> > >  
> > > +/* WARNING: This is called from hash_low_64.S, if you change this prototype,
> > > + *          do not forget to update the assembly call site !
> > > + */
> > 
> > Since we're already policing whitespace on this list today: We're normally
> > not using spaces before exclamation marks.
> 
> And I don't care, I will continue adding them because the opposite is
> fugly :-)

Yeah , I know what you mean . This looks so much more natural .

> There is a limit to what I accept from the style police, it's not like
> Linux has to look like it's written by a single person either.

Good one ! That one goes to the bookmark list . :-)

I agree though , whitespace policing tends to be counter-productive ,
together with (minor) grammar and spelling errors in comments . Still,
people love to point them out so I figured I would do it too .


- Olof
