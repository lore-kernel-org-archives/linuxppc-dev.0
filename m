Return-Path: <dgibson@ozlabs.org>
Date: Wed, 19 Dec 2007 11:04:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Add missing copyright notice for dumptrees.c
Message-ID: <20071219000433.GD12254@localhost.localdomain>
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

When I released libfdt, I forgot to add a copyright notice to
dumptrees.c (probably because the program is so trivial).  Apparently
the lack causes trouble for Debian, so this patch adds one.  I've gone
through the git history and double checked that no-one has touched
this file except me (and I barely have myself since its initial
commit).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/dumptrees.c
===================================================================
--- dtc.orig/tests/dumptrees.c	2007-12-19 10:58:28.000000000 +1100
+++ dtc/tests/dumptrees.c	2007-12-19 10:59:58.000000000 +1100
@@ -1,3 +1,24 @@
+/*
+ * dumptrees - utility for libfdt testing
+ *
+ * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2006.
+ *
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ *                                                                   USA
+ */
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
