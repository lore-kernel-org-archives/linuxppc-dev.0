Return-Path: <dgibson@ozlabs.org>
Date: Wed, 28 Feb 2007 11:46:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Stuart Yoder <b08248@freescale.com>
Subject: Re: [PATCH] powerpc: update interrupt info in booting-without-of.txt
Message-ID: <20070228004627.GD11775@localhost.localdomain>
References: <200702272223.l1RMNKcF030373@ld0164-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200702272223.l1RMNKcF030373@ld0164-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 27, 2007 at 04:23:20PM -0600, Stuart Yoder wrote:
> 
> Create a new section describing how interrupts are represented
> in the device tree.  Added more detail clarified some things.
> 
> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> ---
>  Documentation/powerpc/booting-without-of.txt |  134 ++++++++++++++++++-------
>  1 files changed, 96 insertions(+), 38 deletions(-)
> 
[snip]
> +1) interrupt property
> +---------------------

s/interrupt/interrupts/

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
