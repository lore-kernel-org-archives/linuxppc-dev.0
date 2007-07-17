Return-Path: <rpjday@mindspring.com>
Received: from rubicon.netdirect.ca (nic.NetDirect.CA [216.16.235.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2FA3FDDEE7
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 08:23:24 +1000 (EST)
Date: Tue, 17 Jul 2007 18:21:29 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>
Subject: [PATCH] POWERPC:  Fix misspelled "CONFIG_CHECK_CACHE_COHERENCY"
	Kconfig option.
Message-ID: <Pine.LNX.4.64.0707171819500.21391@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

 arch/powerpc/configs/prpmc2800_defconfig   |    2 +-
 arch/powerpc/platforms/Kconfig.cputype     |    2 +-
 arch/powerpc/platforms/embedded6xx/Kconfig |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/configs/prpmc2800_defconfig b/arch/powerpc/configs/prpmc2800_defconfig
index fb504a7..858f865 100644
--- a/arch/powerpc/configs/prpmc2800_defconfig
+++ b/arch/powerpc/configs/prpmc2800_defconfig
@@ -48,7 +48,7 @@ CONFIG_PPC_STD_MMU_32=y
 # CONFIG_PPC_MM_SLICES is not set
 # CONFIG_SMP is not set
 CONFIG_NOT_COHERENT_CACHE=y
-CONFIG_CONFIG_CHECK_CACHE_COHERENCY=y
+CONFIG_CHECK_CACHE_COHERENCY=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

 #
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index b8b5fde..e4b2aee 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -215,7 +215,7 @@ config NOT_COHERENT_CACHE
 	depends on 4xx || 8xx || E200
 	default y

-config CONFIG_CHECK_CACHE_COHERENCY
+config CHECK_CACHE_COHERENCY
 	bool

 endmenu
diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index bec7726..2d12f77 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -59,7 +59,7 @@ config MPC10X_BRIDGE
 config MV64X60
 	bool
 	select PPC_INDIRECT_PCI
-	select CONFIG_CHECK_CACHE_COHERENCY
+	select CHECK_CACHE_COHERENCY

 config MPC10X_OPENPIC
 	bool
-- 
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://fsdev.net/wiki/index.php?title=Main_Page
========================================================================
