Return-Path: <SRS0=l6JL=FV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1F7C4361B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Dec 2020 22:33:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 023C92376F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Dec 2020 22:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023C92376F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cxmx93Fb4zDqXw
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Dec 2020 09:33:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.126; helo=mga18.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cxmr72xRKzDqW8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Dec 2020 09:29:08 +1100 (AEDT)
IronPort-SDR: 3qCXzJUSFnD7iWNzTtdgaMVBeK4ku7oQ59zy5Pd41K4YBwYlZ4vANi1flPUPhee1bKEjLPm08w
 SldktKIHc3oA==
X-IronPort-AV: E=McAfee;i="6000,8403,9838"; a="163077783"
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400"; d="scan'208";a="163077783"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2020 14:29:04 -0800
IronPort-SDR: 4BOawaZF2J6yu2uS2y68YvD5q/Hj/hUrxSXAV3Q6ZzUXXVnVp4zinHun5a52ncbRaxnvnoVtCd
 gd9YBSPR+Oug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400"; d="scan'208";a="453487488"
Received: from lkp-server02.sh.intel.com (HELO 070e1a605002) ([10.239.97.151])
 by fmsmga001.fm.intel.com with ESMTP; 17 Dec 2020 14:29:03 -0800
Received: from kbuild by 070e1a605002 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kq1le-0001OG-HU; Thu, 17 Dec 2020 22:29:02 +0000
Date: Fri, 18 Dec 2020 06:28:08 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [powerpc:merge] BUILD SUCCESS 3ae03872115a0a158508ee5a91337648aede547d
Message-ID: <5fdbdb78.uas1G1FeGoFGjO4x%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git  merge
branch HEAD: 3ae03872115a0a158508ee5a91337648aede547d  Automatic merge of 'next' into merge (2020-12-17 14:33)

elapsed time: 964m

configs tested: 129
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       omap2plus_defconfig
sh                                  defconfig
powerpc                 mpc8540_ads_defconfig
arm                        vexpress_defconfig
arm                        cerfcube_defconfig
c6x                        evmc6457_defconfig
sh                            shmin_defconfig
xtensa                       common_defconfig
arm                           sunxi_defconfig
arm                            lart_defconfig
mips                    maltaup_xpa_defconfig
arm                          badge4_defconfig
mips                            e55_defconfig
sh                           se7751_defconfig
powerpc                 mpc837x_mds_defconfig
sh                      rts7751r2d1_defconfig
arm                           h3600_defconfig
m68k                        stmark2_defconfig
sh                        sh7757lcr_defconfig
mips                  cavium_octeon_defconfig
arm                       mainstone_defconfig
sh                   sh7724_generic_defconfig
arm                           sama5_defconfig
h8300                    h8300h-sim_defconfig
arm                         orion5x_defconfig
xtensa                         virt_defconfig
mips                          malta_defconfig
arm                         lubbock_defconfig
arm                          iop32x_defconfig
arm                         lpc32xx_defconfig
h8300                       h8s-sim_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                      bmips_stb_defconfig
powerpc                   currituck_defconfig
powerpc                     akebono_defconfig
mips                      fuloong2e_defconfig
powerpc                      cm5200_defconfig
sh                        apsh4ad0a_defconfig
arm                          ep93xx_defconfig
m68k                           sun3_defconfig
arm                            xcep_defconfig
arm                   milbeaut_m10v_defconfig
arm                           spitz_defconfig
xtensa                          iss_defconfig
arm                        spear6xx_defconfig
arm                      footbridge_defconfig
powerpc                     stx_gp3_defconfig
sh                   rts7751r2dplus_defconfig
mips                        workpad_defconfig
sparc                       sparc64_defconfig
mips                        nlm_xlr_defconfig
microblaze                      mmu_defconfig
powerpc                      makalu_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20201217
x86_64               randconfig-a006-20201217
x86_64               randconfig-a002-20201217
x86_64               randconfig-a005-20201217
x86_64               randconfig-a004-20201217
x86_64               randconfig-a001-20201217
i386                 randconfig-a001-20201217
i386                 randconfig-a004-20201217
i386                 randconfig-a003-20201217
i386                 randconfig-a002-20201217
i386                 randconfig-a006-20201217
i386                 randconfig-a005-20201217
i386                 randconfig-a014-20201217
i386                 randconfig-a013-20201217
i386                 randconfig-a012-20201217
i386                 randconfig-a011-20201217
i386                 randconfig-a015-20201217
i386                 randconfig-a016-20201217
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a016-20201217
x86_64               randconfig-a012-20201217
x86_64               randconfig-a013-20201217
x86_64               randconfig-a015-20201217
x86_64               randconfig-a014-20201217
x86_64               randconfig-a011-20201217

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
