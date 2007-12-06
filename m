Return-Path: <dgibson@ozlabs.org>
Date: Thu, 6 Dec 2007 13:07:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Remove space from flex command line
Message-ID: <20071206020750.GE17577@localhost.localdomain>
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

Author: Geoff Levand <geoffrey.levand@am.sony.com>

Apparently some versions of flex don't correctly parse the -o
parameter, if there's a space between the -o and its argument.  So,
this patch removes it.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/Makefile
===================================================================
--- dtc.orig/Makefile	2007-12-06 13:03:41.000000000 +1100
+++ dtc/Makefile	2007-12-06 13:03:45.000000000 +1100
@@ -206,7 +206,7 @@
 
 %.lex.c: %.l
 	@$(VECHO) LEX $@
-	$(LEX) -o $@ $<
+	$(LEX) -o$@ $<
 
 %.tab.c %.tab.h %.output: %.y
 	@$(VECHO) BISON $@

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
