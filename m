Message-ID: <3F4F322B.5030900@mac.com>
Date: Fri, 29 Aug 2003 12:59:55 +0200
From: Ernst Persson <ernstp@mac.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] Bmac also needs crc32
Content-Type: multipart/mixed;
 boundary="------------090000010803030106060903"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------090000010803030106060903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Before you had to enable another net driver och crc32 in library to
compile the bmac driver.

//ernie

--------------090000010803030106060903
Content-Type: text/plain; name="bmac-crc32.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="bmac-crc32.diff"

--- linux-2.6/drivers/net/Makefile.lib	2003-08-28 17:20:35.000000000 +0200
+++ linuxppc-2.5-benh/drivers/net/Makefile.lib	2003-08-29 12:39:36.000000000 +0200
@@ -5,6 +5,7 @@
 obj-$(CONFIG_ARM_AM79C961A)	+= crc32.o
 obj-$(CONFIG_AT1700)		+= crc32.o
 obj-$(CONFIG_ATP)		+= crc32.o
+obj-$(CONFIG_BMAC)              += crc32.o
 obj-$(CONFIG_DE2104X)		+= crc32.o
 obj-$(CONFIG_DE4X5)		+= crc32.o
 obj-$(CONFIG_DECLANCE)		+= crc32.o

--------------090000010803030106060903--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
