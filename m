Return-Path: <dgibson@ozlabs.org>
Date: Fri, 7 Dec 2007 18:08:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Fix silly typo in dtc-checkfails.sh
Message-ID: <20071207070820.GG566@localhost.localdomain>
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

Too much C coding makes for dumb errors in shell.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/dtc-checkfails.sh
===================================================================
--- dtc.orig/tests/dtc-checkfails.sh	2007-12-07 17:14:52.000000000 +1100
+++ dtc/tests/dtc-checkfails.sh	2007-12-07 17:15:21.000000000 +1100
@@ -23,7 +23,7 @@ fi
 
 for c in $CHECKS; do
     if ! grep -E "^(ERROR)|(Warning) \($c\):" $LOG > /dev/null; then
-	FAIL "Failed to trigger check \"%c\""
+	FAIL "Failed to trigger check \"$c\""
     fi
 done
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
