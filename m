Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D304C1A00B0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 07:54:50 +1100 (AEDT)
Date: Thu, 19 Mar 2015 21:54:46 +0100
From: Torsten Duwe <duwe@lst.de>
To: ppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v0 4/4] ppc64le: kgraft config options
Message-ID: <20150319205446.GE19524@lst.de>
References: <20150319203522.GA19524@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150319203522.GA19524@lst.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable kgraft on ppc, fairly trivial.

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 4bc7b62..d82d7c8 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -102,6 +104,7 @@ config PPC
 	select HAVE_IOREMAP_PROT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !CPU_LITTLE_ENDIAN
 	select HAVE_KPROBES
+	select HAVE_KGRAFT
 	select HAVE_ARCH_KGDB
 	select HAVE_KRETPROBES
 	select HAVE_ARCH_TRACEHOOK
@@ -291,6 +294,8 @@ source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
 
+source "kernel/Kconfig.kgraft"
+
 source "arch/powerpc/sysdev/Kconfig"
 source "arch/powerpc/platforms/Kconfig"
 
