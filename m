Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 17AE72BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Nov 2004 05:23:28 +1100 (EST)
Message-ID: <41910B1B.2040707@mvista.com>
Date: Tue, 09 Nov 2004 11:23:23 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="------------010909070104020104080700"
Cc: lkml <linux-kernel@vger.kernel.org>, linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] Remove CONFIG_SERIAL_CONSOLE_BAUD
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.
--------------010909070104020104080700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

No longer needed.

Signed-off-by: Mark Greer <mgreer@mvista.com>

--------------010909070104020104080700
Content-Type: text/plain;
 name="Kconfig.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Kconfig.patch"

diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	2004-11-09 11:20:59 -07:00
+++ b/arch/ppc/Kconfig	2004-11-09 11:20:59 -07:00
@@ -757,11 +757,6 @@
 	bool "PC PS/2 style Keyboard"
 	depends on 4xx || CPM2
 
-config SERIAL_CONSOLE_BAUD
-	int
-	depends on EV64260
-	default "115200"
-
 config PPCBUG_NVRAM
 	bool "Enable reading PPCBUG NVRAM during boot" if PPLUS || LOPEC
 	default y if PPC_PREP

--------------010909070104020104080700--
