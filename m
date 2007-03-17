Return-Path: <dgibson@ozlabs.org>
Date: Sat, 17 Mar 2007 12:25:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 04/17] bootwrapper: Make compression of the kernel image
	optional.
Message-ID: <20070317012530.GC3969@localhost.localdomain>
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172759.GD29784@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070316172759.GD29784@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 16, 2007 at 12:27:59PM -0500, Scott Wood wrote:
> The --no-gzip option can be passed to the wrapper so that the kernel
> image is included uncompressed into the zImage.  This is intended for
> bootloaders where the zImage itself can be compressed, or where boot time
> is considered more important than kernel image size.

Why not.

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
