Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17522.54984.142446.497142@cargo.ozlabs.ibm.com>
Date: Tue, 23 May 2006 19:32:56 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Subject: [PATCH] Add CMSPAR to termbits.h for powerpc and alpha
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some driver wants to use CMSPAR, but it was missing on alpha and
powerpc.  This adds it, with the same value as every other
architecture uses.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/include/asm-alpha/termbits.h b/include/asm-alpha/termbits.h
index f4837fa..5541101 100644
--- a/include/asm-alpha/termbits.h
+++ b/include/asm-alpha/termbits.h
@@ -148,6 +148,7 @@ #define PARODD	00020000
 #define HUPCL	00040000
 
 #define CLOCAL	00100000
+#define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
 /* c_lflag bits */
diff --git a/include/asm-powerpc/termbits.h b/include/asm-powerpc/termbits.h
index ebf6055..6d533b0 100644
--- a/include/asm-powerpc/termbits.h
+++ b/include/asm-powerpc/termbits.h
@@ -153,6 +153,7 @@ #define PARODD	00020000
 #define HUPCL	00040000
 
 #define CLOCAL	00100000
+#define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
 /* c_lflag bits */
