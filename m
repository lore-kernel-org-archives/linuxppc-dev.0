Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao08.cox.net (fed1rmmtao08.cox.net [68.230.241.31])
	by ozlabs.org (Postfix) with ESMTP id CD1702BEA0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Nov 2004 03:43:37 +1100 (EST)
Date: Fri, 19 Nov 2004 09:43:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-embedded@ozlabs.org
Message-ID: <20041119164331.GD16043@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH 2.6.10-rc2] ppc32: Update IBM EMAC copyright / emails
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The following does 3 things:
- Shorten the GPL notice in all of the IBM EMAC driver files
- Generally put Matt Porter on the hook as maintainer, and remove Armin
  Kuster and Johnnie Peters email addrs.
- Fix a typo Wolfgang Denk pointed out to me privately (MontaVista
  Softare).

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.2/drivers/net/ibm_emac/ibm_emac.h	2004-08-04 08:41:48 -07:00
+++ edited/drivers/net/ibm_emac/ibm_emac.h	2004-11-19 09:28:41 -07:00
@@ -1,16 +1,13 @@
 /*
- * ibm_emac.h
+ * drivers/net/ibm_emac/ibm_emac.h
  *
+ * Author: Armin Kuster <source@mvista.com>
+ * Maintainer: Matt Porter <mporter@kernel.crashing.org>
  *
- *      Armin Kuster akuster@mvista.com
- *      June, 2002
- *
- * Copyright 2002 MontaVista Softare Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
+ * 2002 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
  */
 
 #ifndef _IBM_EMAC_H_
--- 1.4/drivers/net/ibm_emac/ibm_emac_core.c	2004-10-20 01:37:15 -07:00
+++ edited/drivers/net/ibm_emac/ibm_emac_core.c	2004-11-19 09:30:15 -07:00
@@ -3,18 +3,18 @@
  *
  * Ethernet driver for the built in ethernet on the IBM 4xx PowerPC
  * processors.
- * 
- * (c) 2003 Benjamin Herrenschmidt <benh@kernel.crashing.org>
  *
- * Based on original work by
+ * Maintainer: Matt Porter <mporter@kernel.crashing.org>
+ *
+ * Based on original work by Armin Kuster and Johnnie Peters
+ * <source@mvista.com>
  *
- *      Armin Kuster <akuster@mvista.com>
- * 	Johnnie Peters <jpeters@mvista.com>
+ * 2002 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ * (c) 2003 Benjamin Herrenschmidt <benh@kernel.crashing.org>
  *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  * TODO
  *       - Check for races in the "remove" code path
  *       - Add some Power Management to the MAC and the PHY
--- 1.2/drivers/net/ibm_emac/ibm_emac_core.h	2004-08-05 07:26:55 -07:00
+++ edited/drivers/net/ibm_emac/ibm_emac_core.h	2004-11-19 09:31:10 -07:00
@@ -1,22 +1,16 @@
 /*
- * ibm_emac_core.h
+ * drivers/net/ibm_emac/ibm_emac_core.h
  *
  * Ethernet driver for the built in ethernet on the IBM 405 PowerPC
  * processor.
  *
- *      Armin Kuster akuster@mvista.com
- *      Sept, 2001
+ * Authors: Armin Kuster and Johnnie Peters <source@mvista.com>
+ * Maintainer: Matt Porter <mporter@kernel.crashing.org>
  *
- *      Orignial driver
- *         Johnnie Peters
- *         jpeters@mvista.com
- *
- * Copyright 2000 MontaVista Softare Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
+ * 2000-2001 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
  */
 
 #ifndef _IBM_EMAC_CORE_H_
--- 1.1/drivers/net/ibm_emac/ibm_emac_debug.c	2004-05-22 10:13:08 -07:00
+++ edited/drivers/net/ibm_emac/ibm_emac_debug.c	2004-11-19 09:31:52 -07:00
@@ -1,17 +1,15 @@
 /*
- * ibm_ocp_debug.c
+ * drivers/net/ibm_emac/ibm_ocp_debug.c
  *
- * This has all the debug routines that where in *_enet.c
+ * Debug rountines for the IBM EMAC driver.
  *
- *      Armin Kuster akuster@mvista.com
- *      April , 2002
+ * Authors: Armin Kuster <source@mvista.com>
+ * Maintainer: Matt Porter <mporter@kernel.crashing.org>
  *
- * Copyright 2002 MontaVista Softare Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
+ * 2002 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
  */
 
 #include <linux/config.h>
--- 1.2/drivers/net/ibm_emac/ibm_emac_mal.c	2004-09-07 23:33:14 -07:00
+++ edited/drivers/net/ibm_emac/ibm_emac_mal.c	2004-11-19 09:32:08 -07:00
@@ -1,15 +1,13 @@
 /*
- * ibm_ocp_mal.c
+ * drivers/net/ibm_emac/ibm_ocp_mal.c
  *
- *      Armin Kuster akuster@mvista.com
- *      Juen, 2002
+ * Authors: Armin Kuster <source@mvista.com>
+ * Maintainer: Matt Porter <mporter@kernel.crashing.org>
  *
- * Copyright 2002 MontaVista Softare Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
+ * 2002 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
  */
 
 #include <linux/config.h>
--- 1.1/drivers/net/ibm_emac/ibm_emac_phy.h	2004-05-22 10:13:08 -07:00
+++ edited/drivers/net/ibm_emac/ibm_emac_phy.h	2004-11-19 09:40:45 -07:00
@@ -1,31 +1,12 @@
-
 /*
- * ibm_emac_phy.h
- *
- *
- *      Benjamin Herrenschmidt <benh@kernel.crashing.org>
- *      February 2003
- *
- * This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR   IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT,  INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
+ * drivers/net/ibm_emac/ibm_emac_phy.h
  *
+ * Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
+ * 
+ * 2003 (c) Benjamin Herrenschmidt. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
  *
  * This file basically duplicates sungem_phy.{c,h} with different PHYs
  * supported. I'm looking into merging that in a single mii layer more
--- 1.1/drivers/net/ibm_emac/ibm_emac_rgmii.h	2004-05-22 10:13:08 -07:00
+++ edited/drivers/net/ibm_emac/ibm_emac_rgmii.h	2004-11-19 09:32:56 -07:00
@@ -2,15 +2,14 @@
  * Defines for the IBM RGMII bridge
  *
  * Based on ocp_zmii.h/ibm_emac_zmii.h
- * Armin Kuster akuster@mvista.com
  *
- * Copyright 2004 MontaVista Software, Inc.
- * Matt Porter <mporter@kernel.crashing.org>
+ * Authors: Armin Kuster <source@mvista.com>
+ * Maintainer: Matt Porter <mporter@kernel.crashing.org>
  *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
+ * 2004 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
  */
 
 #ifndef _IBM_EMAC_RGMII_H_
--- 1.1/drivers/net/ibm_emac/ibm_emac_tah.h	2004-05-22 10:13:08 -07:00
+++ edited/drivers/net/ibm_emac/ibm_emac_tah.h	2004-11-19 09:39:37 -07:00
@@ -1,13 +1,12 @@
 /*
  * Defines for the IBM TAH
  *
- * Copyright 2004 MontaVista Software, Inc.
- * Matt Porter <mporter@kernel.crashing.org>
+ * Author: Matt Porter <mporter@kernel.crashing.org>
  *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
+ * 2004 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
  */
 
 #ifndef _IBM_EMAC_TAH_H
--- 1.1/drivers/net/ibm_emac/ibm_emac_zmii.h	2004-05-22 10:13:08 -07:00
+++ edited/drivers/net/ibm_emac/ibm_emac_zmii.h	2004-11-19 09:33:19 -07:00
@@ -3,15 +3,13 @@
  *
  * Defines for the IBM ZMII bridge
  *
- *      Armin Kuster akuster@mvista.com
- *      Dec, 2001
+ * Authors: Armin Kuster <source@mvista.com>
+ * Maintainer: Matt Porter <mporter@kernel.crashing.org>
  *
- * Copyright 2001 MontaVista Softare Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
+ * 2001 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
  */
 
 #ifndef _IBM_EMAC_ZMII_H_
-- 
Tom Rini
http://gate.crashing.org/~trini/
