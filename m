Return-Path: <dgibson@ozlabs.org>
Date: Sat, 24 Mar 2007 10:40:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] Remove bogus errors from check_chosen.
Message-ID: <20070323234032.GE4459@localhost.localdomain>
References: <20070322161109.GA20512@ld0162-tx32.am.freescale.net>
	<20070323033158.GG28006@localhost.localdomain>
	<20070323150517.GB6060@ld0162-tx32.am.freescale.net>
	<4603F077.9090905@smiths-aerospace.com>
	<20070323153609.GE6060@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070323153609.GE6060@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 23, 2007 at 10:36:09AM -0500, Scott Wood wrote:
> On Fri, Mar 23, 2007 at 11:21:27AM -0400, Jerry Van Baren wrote:
> > The -q[q[q]] I added cuts down/eliminates the moaning, but you still 
> > have to -f force the output which doesn't match what Scott is advocating 
> > if I understand him.
> > 
> > The gcc -Wall is backwards to what we should have, perhaps adding --no* 
> > options like:
> >   --nochosen
> >   --nocpu
> >   --noarmyboots
> > to tell dtc that lonely barefoot blobs are OK.
> 
> There should also be a --no-validate option to turn everything off, if
> the user is confident that the tree is right and doesn't want to get
> broken by new dtcs that have new error categories (or if the user is
> using dtc to compile some other type of tree than an OF-ish device tree).

That's what -f is.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
