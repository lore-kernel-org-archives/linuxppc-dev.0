Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 34AF467A79
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Feb 2005 10:32:35 +1100 (EST)
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id PAA07167
	for <linuxppc-embedded@ozlabs.org>; Tue, 22 Feb 2005 15:32:34 -0800
Message-ID: <421BC111.1050602@mvista.com>
Date: Tue, 22 Feb 2005 16:32:33 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Content-Type: multipart/mixed; boundary="------------040602070105010201070505"
Subject: [PATCH} include/asm-ppc/cpu2.h typo
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
--------------040602070105010201070505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This bug/typo was pointed out to me.  I looked at the 8260 & 8272 
manuals and it should be 0x0002 in both cases.  I don't work with the 
82[67]x processors but it looks like this would have quickly bit anyone 
trying even parity on their serial line.  Nobody uses even parity on 
those platforms?  Is there something I don't know (and the manual isn't 
telling me)?

Mark

--------------040602070105010201070505
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

--------------040602070105010201070505--
