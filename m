Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3FD8DDDDEE
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 14:54:59 +1100 (EST)
Date: Fri, 21 Dec 2007 14:54:59 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Add EHEA and EHCA as modules in the ppc64_defconfig
Message-Id: <20071221145459.c9f85c77.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/configs/ppc64_defconfig |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 5760b9f..7695a4c 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.24-rc4
-# Thu Dec  6 16:49:07 2007
+# Fri Dec 21 14:47:29 2007
 #
 CONFIG_PPC64=y
 
@@ -211,7 +211,7 @@ CONFIG_MMIO_NVRAM=y
 CONFIG_MPIC_U3_HT_IRQS=y
 CONFIG_MPIC_BROKEN_REGREAD=y
 CONFIG_IBMVIO=y
-# CONFIG_IBMEBUS is not set
+CONFIG_IBMEBUS=y
 # CONFIG_PPC_MPC106 is not set
 CONFIG_PPC_970_NAP=y
 CONFIG_PPC_INDIRECT_IO=y
@@ -375,7 +375,7 @@ CONFIG_INET_TUNNEL=y
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
 CONFIG_INET_XFRM_MODE_BEET=y
-# CONFIG_INET_LRO is not set
+CONFIG_INET_LRO=m
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
@@ -929,6 +929,7 @@ CONFIG_SPIDER_NET=m
 CONFIG_NETDEV_10000=y
 # CONFIG_CHELSIO_T1 is not set
 # CONFIG_CHELSIO_T3 is not set
+CONFIG_EHEA=m
 # CONFIG_IXGBE is not set
 CONFIG_IXGB=m
 # CONFIG_IXGB_NAPI is not set
@@ -1558,6 +1559,7 @@ CONFIG_INFINIBAND_ADDR_TRANS=y
 CONFIG_INFINIBAND_MTHCA=m
 CONFIG_INFINIBAND_MTHCA_DEBUG=y
 # CONFIG_INFINIBAND_IPATH is not set
+CONFIG_INFINIBAND_EHCA=m
 # CONFIG_INFINIBAND_AMSO1100 is not set
 # CONFIG_MLX4_INFINIBAND is not set
 CONFIG_INFINIBAND_IPOIB=m
-- 
1.5.3.7

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
