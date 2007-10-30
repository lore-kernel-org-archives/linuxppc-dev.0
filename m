Return-Path: <dgibson@ozlabs.org>
Date: Tue, 30 Oct 2007 13:17:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Remove leftover debugging printf() from mangle-layout
Message-ID: <20071030021715.GA30041@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The mangle-layout testcase/utility had a leftover debugging printf().
This patch removes it.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/mangle-layout.c
===================================================================
--- dtc.orig/tests/mangle-layout.c	2007-10-29 15:58:55.000000000 +1100
+++ dtc/tests/mangle-layout.c	2007-10-29 15:59:16.000000000 +1100
@@ -96,8 +96,6 @@ void add_block(struct bufstate *buf, int
 	}
 
 	offset = ALIGN(buf->size, align);
-	fprintf(stderr, "Moving block %c from %p, to offset %d, size %d\n",
-		block, src, offset, size);
 
 	expand_buf(buf, offset+size);
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
