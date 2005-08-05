Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id A1CE067F06
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Aug 2005 09:07:39 +1000 (EST)
Date: Fri, 5 Aug 2005 16:07:35 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <20050805160735.B10842@cox.net>
References: <20050805154505.A10842@cox.net>
	<20050805155442.4e3dbf8f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050805155442.4e3dbf8f.akpm@osdl.org>;
	from akpm@osdl.org on Fri, Aug 05, 2005 at 03:54:42PM -0700
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: fix ppc440 pagetable attributes
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Aug 05, 2005 at 03:54:42PM -0700, Andrew Morton wrote:
> Matt Porter <mporter@kernel.crashing.org> wrote:
> >
> > This patch fixes a bug in the PPC440 pagetable attributes that breaks  
> >  swap support.  It also adds some notes on the PPC440 attribute fields.
> 
> hm, that looks pretty serious, but it affects all ppc's, yes?

Just PPC440. I originally organized the attributes incorrectly.
 
> Is this needed for 2.6.13?   Are you super-sure it's safe?

This should go into 2.6.13.  I doublechecked it by inspection and
ran numerous tests. It's only existed this long (years) due to the
fact that few people run a disk-based PPC440 system. I would have
sent it up sooner except I wanted to be very sure of my testing
since I don't always trust my own inspection. :)

-Matt
