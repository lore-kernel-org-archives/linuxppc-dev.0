Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3A1A3DDE24
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2007 03:28:55 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l77HSplb024686
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2007 13:28:51 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l77HSoog211920
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2007 11:28:50 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l77HSo5q021284
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2007 11:28:50 -0600
Date: Tue, 7 Aug 2007 12:28:48 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: [PATCH] Remove dtc build cruft from DTS files
Message-ID: <20070807122848.6bdf2f43@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The patch below removes the dtc incantation instructions from the
in-kernel DTS files.  It's not needed, and is prone to being
out-of-date most of the time.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

diff --git a/arch/powerpc/boot/dts/ebony.dts
b/arch/powerpc/boot/dts/ebony.dts index c5f9961..b05a7a0 100644
--- a/arch/powerpc/boot/dts/ebony.dts
+++ b/arch/powerpc/boot/dts/ebony.dts
@@ -9,10 +9,6 @@
  * This file is licensed under the terms of the GNU General Public
  * License version 2.  This program is licensed "as is" without
  * any warranty of any kind, whether express or implied.
- *
- * To build:
- *   dtc -I dts -O asm -o ebony.S -b 0 ebony.dts
- *   dtc -I dts -O dtb -o ebony.dtb -b 0 ebony.dts
  */
 
 / {
diff --git a/arch/powerpc/boot/dts/holly.dts
b/arch/powerpc/boot/dts/holly.dts index 80a4fab..1a4d0be 100644
--- a/arch/powerpc/boot/dts/holly.dts
+++ b/arch/powerpc/boot/dts/holly.dts
@@ -8,10 +8,6 @@
  * This file is licensed under the terms of the GNU General Public
  * License version 2.  This program is licensed "as is" without
  * any warranty of any kind, whether express or implied.
- *
- * To build:
- *   dtc -I dts -O asm -o holly.S -b 0 holly.dts
- *   dtc -I dts -O dtb -o holly.dtb -b 0 holly.dts
  */
 
 / {
diff --git a/arch/powerpc/boot/dts/kuroboxHD.dts
b/arch/powerpc/boot/dts/kuroboxHD.dts index 1225374..b0eeff0 100644
--- a/arch/powerpc/boot/dts/kuroboxHD.dts
+++ b/arch/powerpc/boot/dts/kuroboxHD.dts
@@ -15,9 +15,6 @@
 
 XXXX add flash parts, rtc, ??
 
-build with: "dtc -f -I dts -O dtb -o kuroboxHD.dtb -V 16 kuroboxHD.dts"
-
-
  */
 
 / {
diff --git a/arch/powerpc/boot/dts/kuroboxHG.dts
b/arch/powerpc/boot/dts/kuroboxHG.dts index 579aa8b..ccd15a2 100644
--- a/arch/powerpc/boot/dts/kuroboxHG.dts
+++ b/arch/powerpc/boot/dts/kuroboxHG.dts
@@ -15,9 +15,6 @@
 
 XXXX add flash parts, rtc, ??
 
-build with: "dtc -f -I dts -O dtb -o kuroboxHG.dtb -V 16 kuroboxHG.dts"
-
-
  */
 
 / {
diff --git a/arch/powerpc/boot/dts/prpmc2800.dts
b/arch/powerpc/boot/dts/prpmc2800.dts index 5300b50..e416ea6 100644
--- a/arch/powerpc/boot/dts/prpmc2800.dts
+++ b/arch/powerpc/boot/dts/prpmc2800.dts
@@ -9,10 +9,6 @@
  *
  * Property values that are labeled as "Default" will be updated by
bootwrapper
  * if it can determine the exact PrPMC type.
- *
- * To build:
- *   dtc -I dts -O asm -o prpmc2800.S -b 0 prpmc2800.dts
- *   dtc -I dts -O dtb -o prpmc2800.dtb -b 0 prpmc2800.dts
  */
 
 / {
