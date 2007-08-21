Return-Path: <dgibson@ozlabs.org>
Date: Tue, 21 Aug 2007 12:30:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 05/20] bootwrapper: flatdevtree fixes
Message-ID: <20070821023044.GF15469@localhost.localdomain>
References: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
	<20070820173949.GD30562@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070820173949.GD30562@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 20, 2007 at 12:39:49PM -0500, Scott Wood wrote:
> 1. ft_create_node was returning the internal pointer rather than a phandle.
> 2. ft_find_device_rel was treating a "top" phandle of NULL as an error,
> rather than as the root of the tree.
> 3. Return the node's name when getprop() is called with the "name"
> property.

Hrm.  I'm not convinced.  (1) certainly needs fixing.  (2) is kind of
unclear - there is an ft_find_device() after all for doing root-based
searches.  (3) I really dislike;  I just don't see the point.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
