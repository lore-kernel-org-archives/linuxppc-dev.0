Return-Path: <tnt@246tNt.com>
Received: from outmx015.isp.belgacom.be (outmx015.isp.belgacom.be
	[195.238.2.87])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3338C2BD7B
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2004 21:49:39 +1000 (EST)
Received: from outmx015.isp.belgacom.be (localhost [127.0.0.1])
	by outmx015.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id i8EBnXqj002878
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2004 13:49:33 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4146DB13.1090909@246tNt.com>
Date: Tue, 14 Sep 2004 13:50:43 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tNt.com>
References: <4146D833.8040703@246tNt.com>
In-Reply-To: <4146D833.8040703@246tNt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, Linux PPC Dev <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/9] Small updates for Freescale MPC52xx
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/14 00:07:12+02:00 tnt@246tNt.com
#   ppc: Use interactive console for Freescale MPC52xx when using 
boot/simple
#  
#   Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
#   Signed-off-by: Sylvain Munaut <tnt246tNt.com>
#
# arch/ppc/boot/simple/misc.c
#   2004/09/14 00:07:01+02:00 tnt@246tNt.com +3 -1
#   ppc: Use interactive console for Freescale MPC52xx when using 
boot/simple
#
diff -Nru a/arch/ppc/boot/simple/misc.c b/arch/ppc/boot/simple/misc.c
--- a/arch/ppc/boot/simple/misc.c       2004-09-14 12:47:44 +02:00
+++ b/arch/ppc/boot/simple/misc.c       2004-09-14 12:47:44 +02:00
@@ -48,7 +48,9 @@
  * Val Henson has requested that Gemini doesn't wait for the
  * user to edit the cmdline or not.
  */
-#if (defined(CONFIG_SERIAL_8250_CONSOLE) || defined(CONFIG_VGA_CONSOLE)) \
+#if (defined(CONFIG_SERIAL_8250_CONSOLE) \
+       || defined(CONFIG_VGA_CONSOLE) \
+       || defined(CONFIG_SERIAL_MPC52xx_CONSOLE)) \
        && !defined(CONFIG_GEMINI)
 #define INTERACTIVE_CONSOLE    1
 #endif
