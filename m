Return-Path: <arnd.bergmann@de.ibm.com>
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: powerpc: fix hvc-rtas comments
Date: Fri, 24 Mar 2006 19:58:51 +0100
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
	<20060323213217.GB5538@pb15.lixom.net>
	<200603232336.19683.arnd@arndb.de>
In-Reply-To: <200603232336.19683.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200603241958.52188.arnd.bergmann@de.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

As notice by Olof Johansson, the comment about module_exit
in hvc_rtas is rather confusing, so remove it.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---
Index: linus-2.6/drivers/char/hvc_rtas.c
===================================================================
--- linus-2.6.orig/drivers/char/hvc_rtas.c
+++ linus-2.6/drivers/char/hvc_rtas.c
@@ -119,7 +119,7 @@ static void __exit hvc_rtas_exit(void)
 	if (hvc_rtas_dev)
 		hvc_remove(hvc_rtas_dev);
 }
-module_exit(hvc_rtas_exit); /* before drivers/char/hvc_console.c */
+module_exit(hvc_rtas_exit);
 
 /* This will happen prior to module init.  There is no tty at this time? */
 static int hvc_rtas_console_init(void)
