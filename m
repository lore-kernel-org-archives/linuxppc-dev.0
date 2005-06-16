Return-Path: <dgibson@ozlabs.org>
Date: Thu, 16 Jun 2005 17:08:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-embedded@ozlabs.org,
	u-boot-users <u-boot-users@lists.sourceforge.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, linuxppc64-dev@ozlabs.org
Message-ID: <20050616070816.GE31347@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: More dtc changes
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I now have a git tree for the device tree compiler up at
http://www.ozlabs.org/~dgibson/dtc/dtc.git

Notable changes since the last tarball release:
	- Elementary support for labels.  Labels can go on nodes or
properties in the source tree and are exported to assembler output as
usable symbols
	- phandle reference support.  Cell data (< .. >) can include
references of the form &/path/to/some/node and will be replaced in the
output tree with the output node's phandle.  A phandle will be
generated for the target node if it doesn't already have one.

There's a tarball release as well
http://www.ozlabs.org/~dgibson/dtc/dtc.tar.gz

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
