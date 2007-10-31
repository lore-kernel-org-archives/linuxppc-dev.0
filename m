Return-Path: <dgibson@ozlabs.org>
Date: Wed, 31 Oct 2007 14:26:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [1/2] Merge dtc
Message-ID: <20071031032612.GE7772@localhost.localdomain>
References: <20071031032401.GD7772@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071031032401.GD7772@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This very large patch incorporates a copy of dtc into the kernel
source, in arch/powerpc/boot/dtc-src.  This patch only imports the dtc
sources verbatim, another patch coming to actually link it into the
kernel Makefiles and use the embedded copy of dtc for kernel builds.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Too big for this list.  Full patch at:
	http://ozlabs.org/~dgibson/home/merge-dtc.patch

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
