Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2B3862C0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 20:24:47 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/3] powerpc: several patches for icache flush
Date: Tue, 6 Aug 2013 18:23:29 +0800
Message-ID: <1375784612-14399-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches passed the build test with the following configurations.
	ppc40x_defconfig
        ppc64e_defconfig
        ppc64_defconfig
	mpc85xx_defconfig
	mpc85xx_smp_defconfig
        corenet32_smp_defconfig
        corenet64_smp_defconfig
        ppc44x_defconfig
	mpc885_ads_defconfig
        pseries_defconfig

Boot test on a p5020ds board.

---
Kevin Hao (3):
  powerpc: move the testing of CPU_FTR_COHERENT_ICACHE into    
    __flush_icache_range
  powerpc: remove the symbol __flush_icache_range
  powerpc: check CPU_FTR_COHERENT_ICACHE in __flush_dcache_icache for   
     64bit kernel

 arch/powerpc/include/asm/cacheflush.h | 8 +-------
 arch/powerpc/kernel/misc_32.S         | 2 +-
 arch/powerpc/kernel/misc_64.S         | 9 +++++++--
 arch/powerpc/kernel/ppc_ksyms.c       | 1 -
 4 files changed, 9 insertions(+), 11 deletions(-)

-- 
1.8.3.1
