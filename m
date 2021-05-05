Return-Path: <SRS0=ixLW=KA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AFCC433B4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 May 2021 02:44:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41E24613C4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 May 2021 02:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E24613C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FZgz63wQjz300Q
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 May 2021 12:44:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.126; helo=mga18.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FZgyK24t7z2yRB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 May 2021 12:43:50 +1000 (AEST)
IronPort-SDR: 8nYe42mtmsbDS2OdxLoD0IRUoUFDVGAZSkZ34O3hAb81keja8cixRAJmn6njsjMbaJErgLwkXE
 eJCmHcct/ENw==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="185589918"
X-IronPort-AV: E=Sophos;i="5.82,273,1613462400"; d="scan'208";a="185589918"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2021 19:43:44 -0700
IronPort-SDR: vrbbZOfVBWG8apIT4WD0bLGYO7/ygXtyZWDw/3cfNZura9QPmYl0Y05I3EF3KqeCsAyaVl20Yf
 SR8RfNL+YNdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,273,1613462400"; d="scan'208";a="389026570"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
 by orsmga003.jf.intel.com with ESMTP; 04 May 2021 19:43:43 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1le7Vm-0009ok-Ld; Wed, 05 May 2021 02:43:42 +0000
Date: Wed, 05 May 2021 10:43:26 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [powerpc:next] BUILD SUCCESS c6b05f4e233cc666f003e9fe68b2f765952875a9
Message-ID: <6092064e.QYIXFRH25WtycE7r%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
branch HEAD: c6b05f4e233cc666f003e9fe68b2f765952875a9  powerpc/kconfig: Restore alphabetic order of the selects under CONFIG_PPC

elapsed time: 723m

configs tested: 137
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
arm                             mxs_defconfig
mips                             allyesconfig
mips                    maltaup_xpa_defconfig
arm                           viper_defconfig
arm                          imote2_defconfig
arm                       imx_v6_v7_defconfig
arm                          pcm027_defconfig
powerpc                     tqm8560_defconfig
mips                            ar7_defconfig
powerpc                     asp8347_defconfig
sparc64                          alldefconfig
mips                            e55_defconfig
mips                        vocore2_defconfig
powerpc                        icon_defconfig
powerpc                    socrates_defconfig
powerpc                     tqm5200_defconfig
sh                          sdk7780_defconfig
m68k                          atari_defconfig
m68k                        mvme147_defconfig
arm                      integrator_defconfig
ia64                          tiger_defconfig
m68k                       bvme6000_defconfig
powerpc                     tqm8548_defconfig
m68k                        m5272c3_defconfig
mips                           ip22_defconfig
powerpc                      makalu_defconfig
powerpc                     powernv_defconfig
arm                           sama5_defconfig
arm                           spitz_defconfig
powerpc                        cell_defconfig
nios2                         10m50_defconfig
arm                           h3600_defconfig
powerpc                   lite5200b_defconfig
h8300                               defconfig
arm                            zeus_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     ppa8548_defconfig
arm                          pxa3xx_defconfig
mips                          rm200_defconfig
arc                         haps_hs_defconfig
sh                           se7712_defconfig
arm                          collie_defconfig
arm                          gemini_defconfig
arm                        spear6xx_defconfig
parisc                           allyesconfig
m68k                        stmark2_defconfig
sh                           se7780_defconfig
powerpc                    adder875_defconfig
mips                        nlm_xlp_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210504
i386                 randconfig-a006-20210504
i386                 randconfig-a001-20210504
i386                 randconfig-a005-20210504
i386                 randconfig-a004-20210504
i386                 randconfig-a002-20210504
i386                 randconfig-a003-20210503
i386                 randconfig-a006-20210503
i386                 randconfig-a001-20210503
i386                 randconfig-a005-20210503
i386                 randconfig-a004-20210503
i386                 randconfig-a002-20210503
x86_64               randconfig-a014-20210504
x86_64               randconfig-a015-20210504
x86_64               randconfig-a012-20210504
x86_64               randconfig-a013-20210504
x86_64               randconfig-a011-20210504
x86_64               randconfig-a016-20210504
i386                 randconfig-a015-20210504
i386                 randconfig-a013-20210504
i386                 randconfig-a016-20210504
i386                 randconfig-a014-20210504
i386                 randconfig-a012-20210504
i386                 randconfig-a011-20210504
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20210504
x86_64               randconfig-a003-20210504
x86_64               randconfig-a005-20210504
x86_64               randconfig-a002-20210504
x86_64               randconfig-a006-20210504
x86_64               randconfig-a004-20210504
x86_64               randconfig-a014-20210503
x86_64               randconfig-a015-20210503
x86_64               randconfig-a012-20210503
x86_64               randconfig-a011-20210503
x86_64               randconfig-a013-20210503
x86_64               randconfig-a016-20210503

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
