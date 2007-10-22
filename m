Return-Path: <dgibson@ozlabs.org>
Date: Mon, 22 Oct 2007 11:17:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Olof Johansson <olof@lixom.net>
Subject: Re: ep88xc_defconfig doesn't build
Message-ID: <20071022011712.GA18031@localhost.localdomain>
References: <20071020024355.GA20356@lixom.net>
	<20071022003625.GC17164@localhost.localdomain>
	<20071022011740.GA25222@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071022011740.GA25222@lixom.net>
Cc: linuxppc-dev@ozlabs.org, scott.wood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Oct 21, 2007 at 08:17:40PM -0500, Olof Johansson wrote:
> On Mon, Oct 22, 2007 at 10:36:25AM +1000, David Gibson wrote:
> > On Fri, Oct 19, 2007 at 09:43:55PM -0500, Olof Johansson wrote:
> > > Hi,
> > > 
> > > Did it ever?! I get this with current mainline when building default target:
> > 
> > I think you must have an old dtc; I'm pretty sure I removed the check
> > for /chosen some time ago.  But then I also thought we added a force
> > to the dtc commant line in wrapper ages ago, so now I'm a bit confused.
> 
> Hrm, seems like I had an old version. It's a little annoying that it's a
> moving target and it's impossible to find out form a built binary which
> version it is, besides trying to guess based on file time stamps.
> 
> A nice enhancement could be to have a "dtc -v" and have the makefile
> verify it before using it.

Current dtc has a -v option.  Trying to verify it in Makefile (or more
to the point in the wrapper script) would be a bit.. messy (since the
necessary version kind of depends on the dts file anyway).

Avoiding this sort of hassle is why I'd like to put a copy of dtc in
the kernel tree.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
