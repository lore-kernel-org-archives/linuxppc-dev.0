Return-Path: <dgibson@ozlabs.org>
Date: Fri, 7 Sep 2007 10:49:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 03/10] bootwrapper: flatdevtree fixes
Message-ID: <20070907004913.GD26079@localhost.localdomain>
References: <20070905192001.GA32049@ld0162-tx32.am.freescale.net>
	<20070905192104.GC32113@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905192104.GC32113@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 05, 2007 at 02:21:04PM -0500, Scott Wood wrote:
> 1. ft_create_node was returning the internal pointer rather than a phandle.
> 2. ft_find_device_rel was treating a "top" phandle of NULL as an error,
> rather than as the root of the tree.  The old, absolute ft_find_device
> is removed, and the relative version is renamed to ft_find_device().
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

Although I'm getting really close to obsoleting flatdevtree.c
anyway...

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
