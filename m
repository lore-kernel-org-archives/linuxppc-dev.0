Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 6D68867A76
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Feb 2005 09:36:51 +1100 (EST)
Message-ID: <421D057B.6010607@mvista.com>
Date: Wed, 23 Feb 2005 15:36:43 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="------------020901050606020803030802"
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH][PPC32] Incorrect #define in include/asm-ppc/cpm2.h
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
--------------020901050606020803030802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes the incorrect definition of a macro that sets the 
transmit parity to even on a cpm uart device.

Please apply (once 2.6.12 is open).  Thanks.

Signed-off-by: Mark A. Greer <mgreer@mista.com>
--

--------------020901050606020803030802
Content-Type: text/plain;
 name="cpm2_1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpm2_1.patch"

diff -Nru a/include/asm-ppc/cpm2.h b/include/asm-ppc/cpm2.h
--- a/include/asm-ppc/cpm2.h	2005-02-22 16:26:07 -07:00
+++ b/include/asm-ppc/cpm2.h	2005-02-22 16:26:07 -07:00
@@ -531,7 +531,7 @@
 #define SCU_PSMR_RPM		((ushort)0x000c)
 #define SCU_PSMR_REVP		((ushort)0x0008)
 #define SCU_PSMR_TPM		((ushort)0x0003)
-#define SCU_PSMR_TEVP		((ushort)0x0003)
+#define SCU_PSMR_TEVP		((ushort)0x0002)
 
 /* CPM Transparent mode SCC.
  */

--------------020901050606020803030802--
