Return-Path: <tnt@246tNt.com>
Received: from outmx002.isp.belgacom.be (outmx002.isp.belgacom.be
	[195.238.3.52])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0DF742BD71
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2004 21:47:21 +1000 (EST)
Received: from outmx002.isp.belgacom.be (localhost [127.0.0.1])
	by outmx002.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id i8EBl1LH027352
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2004 13:47:02 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4146DA7D.80504@246tNt.com>
Date: Tue, 14 Sep 2004 13:48:13 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
References: <4146D833.8040703@246tNt.com>
In-Reply-To: <4146D833.8040703@246tNt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, Linux PPC Dev <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/9] Small updates for Freescale MPC52xx
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
#   2004/09/13 21:16:32+02:00 tnt@246tNt.com
#   ppc: Fix missing include in Freescale MPC52xx syslib
#  
#   pgtable.h is needed for _PAGE_IO
#  
#   Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
#
# arch/ppc/syslib/mpc52xx_setup.c
#   2004/09/13 21:16:20+02:00 tnt@246tNt.com +1 -0
#   ppc: Fix missing include in Freescale MPC52xx syslib
#
diff -Nru a/arch/ppc/syslib/mpc52xx_setup.c 
b/arch/ppc/syslib/mpc52xx_setup.c
--- a/arch/ppc/syslib/mpc52xx_setup.c   2004-09-14 12:47:30 +02:00
+++ b/arch/ppc/syslib/mpc52xx_setup.c   2004-09-14 12:47:30 +02:00
@@ -23,6 +23,7 @@
 #include <asm/mpc52xx.h>
 #include <asm/mpc52xx_psc.h>
 #include <asm/ocp.h>
+#include <asm/pgtable.h>
 #include <asm/ppcboot.h>

 extern bd_t __res;
