Return-Path: <dgibson@ozlabs.org>
Date: Sat, 15 Dec 2007 13:58:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3 4/4] Freescale enhanced Local Bus Controller FCM
	NAND support.
Message-ID: <20071215025851.GA8430@localhost.localdomain>
References: <20071214221736.GA21231@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071214221736.GA21231@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org, dwmw2@infradead.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 14, 2007 at 04:17:36PM -0600, Scott Wood wrote:
> Signed-off-by: Nick Spence <nick.spence@freescale.com>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> Fixed some formatting issues, removed some leftover debugging cruft,
> and added a comment about potential conflicts in the interrupt
> handling.

Why is the NAND MTD driver specific to the elbc bus?  And why does it
bind to the elbc node, rather than the nand node under it?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
