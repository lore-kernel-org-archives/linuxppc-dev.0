Return-Path: <vbarshak@dev.rtsoft.ru>
Message-ID: <460032D9.4020207@dev.rtsoft.ru>
Date: Tue, 20 Mar 2007 22:15:37 +0300
From: Valentine Barshak <vbarshak@dev.rtsoft.ru>
MIME-Version: 1.0
To: Linuxppc-embedded@ozlabs.org
Subject: [PATCH] PPC440EP UART0 physical address fix.
Content-Type: multipart/mixed; boundary="------------000202080204030209030400"
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
--------------000202080204030209030400
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Fix PPC440EP UART0 physical address definition used in SERIAL_TEXT_DEBUG.
According to PPC440EP Embedded Processor User Manual it should be 
0xef600300.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>


--------------000202080204030209030400
Content-Type: text/plain;
 name="ppc440ep_uart0_phys_addr_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc440ep_uart0_phys_addr_fix.patch"

diff -ruN linux.orig/include/asm-ppc/ibm44x.h linux/include/asm-ppc/ibm44x.h
--- linux.orig/include/asm-ppc/ibm44x.h	2007-03-20 19:47:06.000000000 +0300
+++ linux/include/asm-ppc/ibm44x.h	2007-03-20 20:04:44.000000000 +0300
@@ -44,7 +44,7 @@
 #define UART0_PHYS_ERPN		4
 #define UART0_PHYS_IO_BASE	0xf0000200
 #elif defined(CONFIG_440EP)
-#define UART0_PHYS_IO_BASE	0xe0000000
+#define UART0_PHYS_IO_BASE	0xef600300
 #else
 #define UART0_PHYS_ERPN		1
 #define UART0_PHYS_IO_BASE	0x40000200

--------------000202080204030209030400--
