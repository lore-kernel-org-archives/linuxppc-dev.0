Return-Path: <dgibson@ozlabs.org>
Date: Mon, 12 Nov 2007 15:11:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [0/4] Embed dtc and libfdt in the kernel (spin the third)
Message-ID: <20071112041126.GB2047@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Another spin of my patches to to embed and use dtc in the kernel
source, rather than relying on it as an external dependency, and to
use libfdt in favour of flatdevtree.c in the bootwrapper.

Only two changes from the last version:
	- trivial changes to make the patches apply to the current
tree
	- fdt_init() now calls fdt_open_into() to make sure the tree
is ready to go.  This means the bootwrapper using libfdt can cope if
supplied with a v16 tree, or a tree with the blocks in a non-preferred
order.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
