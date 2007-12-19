Return-Path: <dgibson@ozlabs.org>
Date: Wed, 19 Dec 2007 16:07:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Update TODO files
Message-ID: <20071219050747.GH12254@localhost.localdomain>
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

This patch makes a bunch of updates to the TODO files for dtc and
libfdt, some of them rather overdue.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/TODO
===================================================================
--- dtc.orig/TODO	2007-12-19 10:52:12.000000000 +1100
+++ dtc/TODO	2007-12-19 15:50:22.000000000 +1100
@@ -1,14 +1,8 @@
 - Bugfixes:
 	* Proper handling of boot cpu information
-- Error handling / reporting
-	* Better categorization of errors into severity levels
-	* Don't stop checking for later errors because of earlier ones
-	  whenever possible
 - Generate mem reserve map
 	* linux,reserve-map property
 	* generating reserve entry for device tree itself
 	* generating reserve entries from tce, rtas etc. properties
-
-
-- Testsuite
-- Actually number releases, all that kind of jazz
+- Expression support
+- Macro system
Index: dtc/libfdt/TODO
===================================================================
--- dtc.orig/libfdt/TODO	2007-12-19 10:52:12.000000000 +1100
+++ dtc/libfdt/TODO	2007-12-19 15:58:49.000000000 +1100
@@ -1,5 +1,3 @@
-- Find node by linux,phandle property
 - Tree traversal functions
 - Graft function
-- Merge into dtc
-- Make fdt_open_into() re-arrange properly
+- Complete libfdt.h documenting comments

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
