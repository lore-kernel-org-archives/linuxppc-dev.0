Return-Path: <alistair.popple@gmail.com>
Received: from mail-da0-x22b.google.com (mail-da0-x22b.google.com
 [IPv6:2607:f8b0:400e:c00::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2D6CC2C0181
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Apr 2013 13:43:28 +1000 (EST)
Received: by mail-da0-f43.google.com with SMTP id h21so292200dal.2
 for <linuxppc-dev@ozlabs.org>; Sun, 28 Apr 2013 20:43:26 -0700 (PDT)
Sender: Alistair Popple <alistair.popple@gmail.com>
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc: Update default configurations
Date: Mon, 29 Apr 2013 13:42:44 +1000
Message-Id: <1367206964-6319-3-git-send-email-alistair@popple.id.au>
In-Reply-To: <1367206964-6319-1-git-send-email-alistair@popple.id.au>
References: <1367206964-6319-1-git-send-email-alistair@popple.id.au>
Cc: Alistair Popple <alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update default configurations for systems with CONFIG_BOOTX_TEXT
selected so that they continue to print early debug messages as is
currently the case.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/configs/c2k_defconfig    |    2 ++
 arch/powerpc/configs/g5_defconfig     |    2 ++
 arch/powerpc/configs/maple_defconfig  |    2 ++
 arch/powerpc/configs/pmac32_defconfig |    2 ++
 arch/powerpc/configs/ppc64_defconfig  |    2 ++
 arch/powerpc/configs/ppc6xx_defconfig |    2 ++
 6 files changed, 12 insertions(+)

diff --git a/arch/powerpc/configs/c2k_defconfig b/arch/powerpc/configs/c2k_defconfig
index 2a84fd7..671a8f9 100644
--- a/arch/powerpc/configs/c2k_defconfig
+++ b/arch/powerpc/configs/c2k_defconfig
@@ -423,6 +423,8 @@ CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_DEBUG_STACK_USAGE=y
 CONFIG_BOOTX_TEXT=y
+CONFIG_PPC_EARLY_DEBUG=y
+CONFIG_PPC_EARLY_DEBUG_BOOTX=y
 CONFIG_KEYS=y
 CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_SECURITY=y
diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index 07b7f2a..1ea22fc 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -284,6 +284,8 @@ CONFIG_DEBUG_MUTEXES=y
 CONFIG_LATENCYTOP=y
 CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_BOOTX_TEXT=y
+CONFIG_PPC_EARLY_DEBUG=y
+CONFIG_PPC_EARLY_DEBUG_BOOTX=y
 CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_ECB=m
diff --git a/arch/powerpc/configs/maple_defconfig b/arch/powerpc/configs/maple_defconfig
index 02ac96b..2a5afac 100644
--- a/arch/powerpc/configs/maple_defconfig
+++ b/arch/powerpc/configs/maple_defconfig
@@ -138,6 +138,8 @@ CONFIG_DEBUG_STACK_USAGE=y
 CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
 CONFIG_BOOTX_TEXT=y
+CONFIG_PPC_EARLY_DEBUG=y
+CONFIG_PPC_EARLY_DEBUG_BOOTX=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig
index 29767a8..a73626b 100644
--- a/arch/powerpc/configs/pmac32_defconfig
+++ b/arch/powerpc/configs/pmac32_defconfig
@@ -350,6 +350,8 @@ CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
 CONFIG_BOOTX_TEXT=y
+CONFIG_PPC_EARLY_DEBUG=y
+CONFIG_PPC_EARLY_DEBUG_BOOTX=y
 CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_MD4=m
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index aef3f71..c86fcb9 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -398,6 +398,8 @@ CONFIG_FTR_FIXUP_SELFTEST=y
 CONFIG_MSI_BITMAP_SELFTEST=y
 CONFIG_XMON=y
 CONFIG_BOOTX_TEXT=y
+CONFIG_PPC_EARLY_DEBUG=y
+CONFIG_PPC_EARLY_DEBUG_BOOTX=y
 CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_PCBC=m
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index be1cb6e..20ebfaf 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -1264,6 +1264,8 @@ CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_DEBUG_STACK_USAGE=y
 CONFIG_XMON=y
 CONFIG_BOOTX_TEXT=y
+CONFIG_PPC_EARLY_DEBUG=y
+CONFIG_PPC_EARLY_DEBUG_BOOTX=y
 CONFIG_KEYS=y
 CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_SECURITY=y
-- 
1.7.10.4
