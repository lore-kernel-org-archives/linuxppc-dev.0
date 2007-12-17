Return-Path: <dgibson@ozlabs.org>
Date: Mon, 17 Dec 2007 15:14:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH 7/7] [POWERPC] Xilinx: Update booting-without-of.
Message-ID: <20071217041455.GA3477@localhost.localdomain>
References: <1197589413-5965-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-2-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-3-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-4-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-5-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-6-git-send-email-stephen.neuendorffer@xilinx.com>
	<20071213234151.D0B3DE80061@mail20-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071213234151.D0B3DE80061@mail20-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, simekm2@fel.cvut.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 13, 2007 at 03:43:33PM -0800, Stephen Neuendorffer wrote:
> This now better describes what the UBoot device tree generator actually does.  In particular:
> 
> 1) Nodes have a label derived from the device name, and a node name
> derived from the device type.
> 2) Usage of compound nodes (representing more than one device in the same IP) which actually works.  This requires having a valid compatible node, and all the other things that a bus normally has.  I've chosen 'xlnx,compound' as the bus name to describe these compound nodes.

I'm not sure I like this xlnx,compound business, although maybe it's
the best you can do.

> 3) Uartlite requires a port-number property for the console to work.

Why?  In general we try to avoid magical sequence numbers - cell-index
should *only* be used when it's needed to index or program some shared
register.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
