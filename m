Return-Path: <pantelis.antoniou@gmail.com>
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.192])
	by ozlabs.org (Postfix) with ESMTP id 48EBF6865E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Nov 2005 05:34:32 +1100 (EST)
Received: by nproxy.gmail.com with SMTP id y38so115464nfb
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 03 Nov 2005 10:34:31 -0800 (PST)
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
To: akpm@osdl.org
Date: Thu, 3 Nov 2005 20:39:26 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200511032039.27395.pantelis.antoniou@gmail.com>
Cc: Kumar <kumar.gala@freescale.com>, Dan Malek <dan@embeddedalley.com>, Gala,
	linuxppc-embedded@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] ppc32: Put CPM1 config option
Reply-To: pantelis.antoniou@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kconfig patch needed by fs_enet to work.
Works like CONFIG_CPM2.

diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -746,7 +746,17 @@ config MPC834x
 	bool
 	default y if MPC834x_SYS
 
+config CPM1
+	bool
+	depends on 8xx
+	default y
+	help
+	  The CPM1 (Communications Processor Module) is a coprocessor on
+	  embedded CPUs made by Motorola.  Selecting this option means that
+	  you wish to build a kernel for a machine with a CPM1 coprocessor
+	  on it (8xx, 827x, 8560).
+
 config CPM2
 	bool
 	depends on 8260 || MPC8560 || MPC8555
 config PPC_GEN550
