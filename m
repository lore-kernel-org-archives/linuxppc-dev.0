Return-Path: <dgibson@ozlabs.org>
Date: Tue, 21 Aug 2007 12:01:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 03/20] bootwrapper: dt_xlate_range() bugfixes
Message-ID: <20070821020131.GD15469@localhost.localdomain>
References: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
	<20070820173946.GB30562@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070820173946.GB30562@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 20, 2007 at 12:39:46PM -0500, Scott Wood wrote:
> 1. The check whether ranges fits in the buffer was using elements rather
> than bytes.
> 2. Empty ranges were not properly treated as transparent, and missing
> ranges were treated as transparent.
> 3. The loop terminated when translating from the root rather than to.  Once
> bug #2 was fixed, it failed due to a missing ranges in the root node.
> 4. In decoding the ranges property, the #size-cells used was that of
> the parent, not the child.

> Signed-off-by: Scott Wood <scottwood@freescale.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
