Return-Path: <dgibson@ozlabs.org>
Date: Tue, 30 Oct 2007 11:10:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] MTD: small physmap_of partition parsing fixes
Message-ID: <20071030001021.GA29263@localhost.localdomain>
References: <20071029202902.GA2200@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071029202902.GA2200@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 29, 2007 at 11:29:02PM +0300, Valentine Barshak wrote:
> Use of_get_next_child for proper ref counting as suggested by Stephen Rothwell
> and remove add_mtd_partitions from parse_partitions to avoid duplicate
> mtd device registration for RedBoot partitions.
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>

Oops, yes.  I think the extra add_mtd_partitions() was left over from
an earlier version which always did the add_mtd_partitions() from
within the probe function.

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
