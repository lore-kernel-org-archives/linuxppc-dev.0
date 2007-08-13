Return-Path: <dgibson@ozlabs.org>
Date: Mon, 13 Aug 2007 11:05:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Device tree aware EMAC driver
Message-ID: <20070813010533.GA18526@localhost.localdomain>
References: <20070807062231.GB8351@localhost.localdomain>
	<20070808031643.GK10345@bakeyournoodle.com>
	<7af683d3d78a51373d071b126c51b53a@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7af683d3d78a51373d071b126c51b53a@kernel.crashing.org>
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 10, 2007 at 10:39:31PM +0200, Segher Boessenkool wrote:
> >  * In drivers/net/ibm_newemac/Makefile, I think the preferred method is
> >    to use ibm_newemac-y rather than ibm_newemac-objs.
> 
> I thought it was the other way around, so I checked with the
> Kbuild maintainer, and indeed you are correct.

Changed accordingly.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
