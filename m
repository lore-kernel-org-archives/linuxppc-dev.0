Return-Path: <dgibson@ozlabs.org>
Date: Wed, 10 Oct 2007 12:35:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Build failure on treeboot-walnut.cg
Message-ID: <20071010023554.GB32426@localhost.localdomain>
References: <fa686aa40709251546p725e66dcsbc0483cadb3ec3fb@mail.gmail.com>
	<470AA224.7050709@freescale.com>
	<20071009030729.GI12499@localhost.localdomain>
	<20071009160645.GA4304@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071009160645.GA4304@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.com, Paul Mackerras <paulus@samba.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 09, 2007 at 11:06:45AM -0500, Scott Wood wrote:
> On Tue, Oct 09, 2007 at 01:07:29PM +1000, David Gibson wrote:
> > On Mon, Oct 08, 2007 at 04:33:24PM -0500, Timur Tabi wrote:
> > > Question: I'm building a kernel for the 8610.  Why is treeboot-walnut.c
> > > being compiled at all?
> > 
> > Policy.  Compiling everything means build bugs - like this one - can
> > be found by everybody, not just those building for the specific
> > obscure platform.
> 
> Of course, it also introduces bugs that wouldn't have been an issue if we
> didn't try to build everything with the same toolchain. :-P
> 
> I'm also somewhat worried what it'll do to build time as platforms
> accumulate.

It also provides incentive to keep the bootwrapper small...

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
