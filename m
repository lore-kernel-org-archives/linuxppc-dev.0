Return-Path: <dgibson@ozlabs.org>
Date: Mon, 17 Dec 2007 16:39:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [DTC][PATCH] Fix cross-compile building
Message-ID: <20071217053920.GD3477@localhost.localdomain>
References: <Pine.LNX.4.64.0712071227280.1788@blarg.am.freescale.net>
	<20071208003604.GH566@localhost.localdomain>
	<A388C2C2-2452-4E70-A5DA-F61B0E3A2B22@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A388C2C2-2452-4E70-A5DA-F61B0E3A2B22@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>, stuarth@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 13, 2007 at 11:57:48PM -0600, Kumar Gala wrote:
> 
> On Dec 7, 2007, at 6:36 PM, David Gibson wrote:
> 
> > On Fri, Dec 07, 2007 at 12:28:20PM -0600, Kumar Gala wrote:
> >> From: Stuart Hughes <stuarth@freescale.com>
> >>
> >> This patch allows you to build the DTC source without making the
> >> tests directory.  This is necessary when cross compiling as the
> >> dumptest (and other) files cannot be run/used on the host system.
> >> To use this use: 'make TESTS='
> >
> > I think this is a silly way of doing this.  Instead create a new
> > target which builds everything but the tests.
> >
> > Say,
> >
> > 	all: cross tests
> >
> > 	cross: dtc ftdump libfdt
> 
> shouldn't we do this the other way around, it seems odd to build the  
> tests always or at least as part of the all target.

Hrm.  Yeah, I guess so.

The idea was to encourage the tests to be used as much as possible,
but I guess there's not all that much value to building them without
running them.

Patch forthcoming.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
