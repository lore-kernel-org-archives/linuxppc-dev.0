Return-Path: <dgibson@ozlabs.org>
Date: Wed, 19 Sep 2007 13:11:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 05/28] bootwrapper: Support all-in-one PCI nodes in
	cuboot-pq2.
Message-ID: <20070919031143.GG23646@localhost.localdomain>
References: <20070917165643.GA6545@loki.buserror.net>
	<20070917165734.GE6563@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070917165734.GE6563@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 17, 2007 at 11:57:34AM -0500, Scott Wood wrote:
> Consensus was reached to put PCI nodes at the root of the tree (and not
> under /soc), but the phandle to a control node was rejected in favor of
> simply not worrying about /pci/reg overlapping /soc/ranges.
> 
> This updates cuboot-82xx to not look for the phandle.

I preferred the split-node method, but as you say, this consensus has
been reached for now.

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
