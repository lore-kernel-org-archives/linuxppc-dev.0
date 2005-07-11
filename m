Return-Path: <dgibson@ozlabs.org>
Date: Mon, 11 Jul 2005 16:30:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Message-ID: <20050711063025.GA11752@localhost.localdomain>
References: <1120859097.8609.15.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1120859097.8609.15.camel@cashmere.sps.mot.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: PATCH: Add memreserve to DTC
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 08, 2005 at 04:44:58PM -0500, Jon Loeliger wrote:
> David and Ben,
> 
> This patch adds support for memreserve to the DTC's notion
> of the "source file".  That is, you can now say this:
>         
>         
>         memreserve =	<
>         		 0000 0001  0000 0002
>         		 0000 0003  0000 0004
>         		>
>         
>         / {
>         	model = "MPC8555CDS";
>         	compatible = "MPC85xxCDS";
>         	#address-cells = <2>;
>         	#size-cells = <2>;
>         	linux,phandle = <100>;
> 
> There is minor fiddling with the -R flag that needs to be
> resolved at this point.
> 
> I've included read and writing for the source and blob formats,
> but don't have a clue what to do with the /proc/devices format.
> 
> I've also tinkered the Makefile to do automatic dependency
> file generation and inclusion.  Yep, I got bit by out of
> date dependencies during my development here. :-)

I applied the dependency portions of the patch to the git tree, with
some tweaks to fix some corner cases.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
