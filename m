Return-Path: <B43198@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0139.outbound.protection.outlook.com [157.56.111.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C11EE1A08E2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 19:36:39 +1100 (AEDT)
From: Bogdan Purcareata <bogdan.purcareata@freescale.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/3] powerpc: Enable HAVE_ARCH_SECCOMP_FILTER
Date: Wed, 11 Feb 2015 08:36:18 +0000
Message-ID: <1423643778-32525-4-git-send-email-bogdan.purcareata@freescale.com>
In-Reply-To: <1423643778-32525-1-git-send-email-bogdan.purcareata@freescale.com>
References: <1423643778-32525-1-git-send-email-bogdan.purcareata@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: pmoore@redhat.com, linux-kernel@vger.kernel.org,
 Bogdan Purcareata <bogdan.purcareata@freescale.com>,
 strosake@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Bogdan Purcareata <bogdan.purcareata@freescale.com>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a2a168e..72f363e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -104,6 +104,7 @@ config PPC
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !CPU_LITTLE_ENDIAN
 	select HAVE_KPROBES
 	select HAVE_ARCH_KGDB
+	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_KRETPROBES
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_MEMBLOCK
-- 
2.1.4
