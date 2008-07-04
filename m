Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18542.970.878558.275775@cargo.ozlabs.ibm.com>
Date: Fri, 4 Jul 2008 21:04:42 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Update maintainers for powerpc
Cc: linuxppc-dev@ozlabs.org, trini@kernel.crashing.org, anton@samba.org,
	akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This updates the MAINTAINERS entries for powerpc.  It adds Ben H to
the overall Linux for PowerPC entry and makes it clear this covers
both 32-bit and 64-bit machines.  It removes the separate entry we had
for Linux on 64-bit PowerPC where Anton and I were listed as
maintainers - Anton hasn't been involved in the day-to-day maintenance
of the code for several years.  Finally, it removes the entry for the
Linux for PowerPC boot code where Tom Rini was listed as the
maintainer.  That code got completely rewritten when we merged
32-bit and 64-bit, and I and the various platform maintainers have
been maintaining that code since.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
Linus, could this go in for 2.6.26 please?

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f0ec46..e1b62c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2474,9 +2474,11 @@ M:	James.Bottomley@HansenPartnership.com
 W:	http://www.hansenpartnership.com/voyager
 S:	Maintained
 
-LINUX FOR POWERPC
+LINUX FOR POWERPC (32-BIT AND 64-BIT)
 P:	Paul Mackerras
 M:	paulus@samba.org
+P:	Benjamin Herrenschmidt
+M:	benh@kernel.crashing.org
 W:	http://www.penguinppc.org/
 L:	linuxppc-dev@ozlabs.org
 T:	git kernel.org:/pub/scm/linux/kernel/git/paulus/powerpc.git
@@ -2516,13 +2518,6 @@ W:	http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex
 L:	linuxppc-dev@ozlabs.org
 S:	Maintained
 
-LINUX FOR POWERPC BOOT CODE
-P:	Tom Rini
-M:	trini@kernel.crashing.org
-W:	http://www.penguinppc.org/
-L:	linuxppc-dev@ozlabs.org
-S:	Maintained
-
 LINUX FOR POWERPC EMBEDDED PPC8XX
 P:	Vitaly Bordug
 M:	vitb@kernel.crashing.org
@@ -2551,17 +2546,6 @@ P:	Arnaldo Carvalho de Melo
 M:	acme@ghostprotocols.net
 S:	Maintained
 
-LINUX FOR 64BIT POWERPC
-P:	Paul Mackerras
-M:	paulus@samba.org
-M:	paulus@au.ibm.com
-P:	Anton Blanchard
-M:	anton@samba.org
-M:	anton@au.ibm.com
-W:	http://www.penguinppc.org/ppc64/
-L:	linuxppc-dev@ozlabs.org
-S:	Supported
-
 LINUX SECURITY MODULE (LSM) FRAMEWORK
 P:	Chris Wright
 M:	chrisw@sous-sol.org
