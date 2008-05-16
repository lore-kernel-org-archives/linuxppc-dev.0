Return-Path: <dgibson@ozlabs.org>
Date: Fri, 16 May 2008 11:56:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Remi Machet <rmachet@slac.stanford.edu>
Subject: Re: [PATCH 2/5] powerpc: boot code for the C2K
Message-ID: <20080516015647.GB27188@yookeroo.seuss>
References: <1210897421.13992.14.camel@pcds-ts102.slac.stanford.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1210897421.13992.14.camel@pcds-ts102.slac.stanford.edu>
Cc: Linux PPC <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 15, 2008 at 05:23:40PM -0700, Remi Machet wrote:
> Support for the C2K cPCI Single Board Computer from GEFanuc
> (PowerPC MPC7448 with a Marvell MV64460 chipset)
> All features of the board are not supported yet, but the board
> boots, flash works, all Ethernet ports are working and PCI 
> devices are all found (USB and SATA on PCI1 do not work yet).
> 
> Part 2 of 5: support for the board in arch/powerpc/boot.
> 
> Signed-off-by: Remi Machet <rmachet@slac.stanford.edu>

[snip]
> +BSS_STACK(16*KB);

16kB is a really big stack for a bootwrapper.  Do you really need this
much?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
