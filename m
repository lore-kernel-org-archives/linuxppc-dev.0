Return-Path: <wanlong.gao@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7DEC4B6F19
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 10 Apr 2011 04:10:51 +1000 (EST)
Received: by iwc10 with SMTP id 10so5018845iwc.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 09 Apr 2011 11:10:46 -0700 (PDT)
From: wanlong.gao@gmail.com
To: benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
	grant.likely@secretlab.ca, galak@kernel.crashing.org, sfr@canb.auug.org.au,
	jwboyer@linux.vnet.ibm.com, david.woodhouse@intel.com,
	akpm@linux-foundation.org, mingo@elte.hu, geoff@infradead.org
Subject: [PATCH] powerpc:fix build warning of the defconfigs
Date: Sun, 10 Apr 2011 02:09:46 +0800
Message-Id: <1302372586-2637-1-git-send-email-wanlong.gao@gmail.com>
Cc: Wanlong Gao <wanlong.gao@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wanlong Gao <wanlong.gao@gmail.com>

BT_L2CAP and BT_SCO have changed to bool .
Value 'm' has invalid .

Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>
---
 arch/powerpc/configs/c2k_defconfig    |    4 ++--
 arch/powerpc/configs/pmac32_defconfig |    4 ++--
 arch/powerpc/configs/ppc6xx_defconfig |    4 ++--
 arch/powerpc/configs/ps3_defconfig    |    4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/configs/c2k_defconfig b/arch/powerpc/configs/c2k_defconfig
index f9e6a3e..2a84fd7 100644
--- a/arch/powerpc/configs/c2k_defconfig
+++ b/arch/powerpc/configs/c2k_defconfig
@@ -132,8 +132,8 @@ CONFIG_NET_CLS_RSVP=m
 CONFIG_NET_CLS_RSVP6=m
 CONFIG_NET_CLS_IND=y
 CONFIG_BT=m
-CONFIG_BT_L2CAP=m
-CONFIG_BT_SCO=m
+CONFIG_BT_L2CAP=y
+CONFIG_BT_SCO=y
 CONFIG_BT_RFCOMM=m
 CONFIG_BT_RFCOMM_TTY=y
 CONFIG_BT_BNEP=m
diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig
index ac4fc41..f8b394a 100644
--- a/arch/powerpc/configs/pmac32_defconfig
+++ b/arch/powerpc/configs/pmac32_defconfig
@@ -112,8 +112,8 @@ CONFIG_IRDA_CACHE_LAST_LSAP=y
 CONFIG_IRDA_FAST_RR=y
 CONFIG_IRTTY_SIR=m
 CONFIG_BT=m
-CONFIG_BT_L2CAP=m
-CONFIG_BT_SCO=m
+CONFIG_BT_L2CAP=y
+CONFIG_BT_SCO=y
 CONFIG_BT_RFCOMM=m
 CONFIG_BT_RFCOMM_TTY=y
 CONFIG_BT_BNEP=m
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 0a10fb0..2142089 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -351,8 +351,8 @@ CONFIG_VLSI_FIR=m
 CONFIG_VIA_FIR=m
 CONFIG_MCS_FIR=m
 CONFIG_BT=m
-CONFIG_BT_L2CAP=m
-CONFIG_BT_SCO=m
+CONFIG_BT_L2CAP=y
+CONFIG_BT_SCO=y
 CONFIG_BT_RFCOMM=m
 CONFIG_BT_RFCOMM_TTY=y
 CONFIG_BT_BNEP=m
diff --git a/arch/powerpc/configs/ps3_defconfig b/arch/powerpc/configs/ps3_defconfig
index caba919..6472322 100644
--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -52,8 +52,8 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_INET_DIAG is not set
 CONFIG_IPV6=y
 CONFIG_BT=m
-CONFIG_BT_L2CAP=m
-CONFIG_BT_SCO=m
+CONFIG_BT_L2CAP=y
+CONFIG_BT_SCO=y
 CONFIG_BT_RFCOMM=m
 CONFIG_BT_RFCOMM_TTY=y
 CONFIG_BT_BNEP=m
-- 
1.7.3
