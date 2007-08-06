Return-Path: <dgibson@ozlabs.org>
Date: Mon, 6 Aug 2007 14:31:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Message-ID: <20070806043147.GC6103@localhost.localdomain>
References: <20070730150648.GA5005@ru.mvista.com>
	<20070801020836.GB31391@localhost.localdomain>
	<65ff446478a9fd0a48061079d5f04f8f@kernel.crashing.org>
	<20070801050422.GI31391@localhost.localdomain>
	<20070801054751.GM31391@localhost.localdomain>
	<46B357D3.1040608@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46B357D3.1040608@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 03, 2007 at 08:29:07PM +0400, Sergei Shtylyov wrote:
> David Gibson wrote:
> 
> > Duh, forgot to attach the actual patch.  Here it is:
> 
> > Index: working-2.6/Documentation/powerpc/booting-without-of.txt
> > ===================================================================
> > --- working-2.6.orig/Documentation/powerpc/booting-without-of.txt	2007-07-30 17:07:14.000000000 +1000
> > +++ working-2.6/Documentation/powerpc/booting-without-of.txt	2007-07-30 17:07:14.000000000 +1000
> > @@ -1757,45 +1757,23 @@ platforms are moved over to use the flat
> >  		};
> >  	};
> >  
> > -    j) Flash chip nodes
> > +   j) CFI or JEDEC memory-mapped NOR flash
> >  
> >      Flash chips (Memory Technology Devices) are often used for solid state
> >      file systems on embedded devices.
> >  
> > -    Required properties:
> > +     - compatible : should contain the specific model of flash chip(s) used
> > +       followed by either "cfi-flash" or "jedec-flash"
> 
>     Duh, have nearly forgotten to complain about "-flash" suffix.  Isn't it 
> superfluous?

For CFI, I guess so.  But don't JEDEC standardise other things as well
as flash?  I think "-flash" makes the description a bit more obvious,
but I'll be swayed if a few other people chime in with opinions on this.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
