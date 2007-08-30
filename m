Return-Path: <dgibson@ozlabs.org>
Date: Thu, 30 Aug 2007 10:34:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 7/9] bootwrapper: Only print MAC addresses when the node
	is actually present.
Message-ID: <20070830003430.GF21072@localhost.localdomain>
References: <20070829164534.GA31585@ld0162-tx32.am.freescale.net>
	<20070829164743.GE31640@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070829164743.GE31640@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 29, 2007 at 11:47:43AM -0500, Scott Wood wrote:
> Some firmwares (such as PlanetCore) only provide a base MAC address, and
> expect the kernel to set certain bits to generate the addresses for the
> other ports.  As such, MAC addresses are generated that may not correspond
> to actual hardware.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
