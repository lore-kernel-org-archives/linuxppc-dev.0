Return-Path: <SRS0=TBQx=FN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA352C433FE
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Dec 2020 04:44:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C0B223B4B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Dec 2020 04:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C0B223B4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CrPZx1G37zDqnf
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Dec 2020 15:44:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.65; helo=mga03.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CrPYH3z7BzDqdb
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2020 15:42:42 +1100 (AEDT)
IronPort-SDR: awjKDNA42xYDqikNTYZ6uIw068jK2ZIEJnrYjTNT6fvapY/ZzRjT1olbBfa5rjzihqlYiVF99+
 lzZIjVQEscAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="174136925"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; d="scan'208";a="174136925"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2020 20:42:39 -0800
IronPort-SDR: /bgDVzZ7rn/WPdAAp9eBjnt9ebnOMSWWcDuK3VO08U+Lfu3Qh30Wx67h5FElVXve/JpjIeHZkB
 YdAPS3cZsZQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; d="scan'208";a="348182571"
Received: from lkp-server02.sh.intel.com (HELO 68de7028daff) ([10.239.97.151])
 by orsmga002.jf.intel.com with ESMTP; 08 Dec 2020 20:42:38 -0800
Received: from kbuild by 68de7028daff with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kmrJF-00000L-OY; Wed, 09 Dec 2020 04:42:37 +0000
Date: Wed, 09 Dec 2020 12:42:03 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [powerpc:fixes-test] BUILD SUCCESS
 5eedf9fe8db23313df104576845cec5f481b9b60
Message-ID: <5fd0559b.40hQJ0YgXFZXuz5k%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git  fixes-test
branch HEAD: 5eedf9fe8db23313df104576845cec5f481b9b60  powerpc/mm: Fix KUAP warning by providing copy_from_kernel_nofault_allowed()

elapsed time: 884m

configs tested: 129
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
powerpc                          g5_defconfig
powerpc                     skiroot_defconfig
sh                   rts7751r2dplus_defconfig
sh                     magicpanelr2_defconfig
powerpc                       maple_defconfig
arm                             rpc_defconfig
parisc                generic-32bit_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                        warp_defconfig
sh                          lboxre2_defconfig
powerpc64                           defconfig
powerpc                     pseries_defconfig
powerpc                 canyonlands_defconfig
powerpc                 mpc834x_mds_defconfig
sh                         apsh4a3a_defconfig
x86_64                           alldefconfig
powerpc                         wii_defconfig
powerpc                     mpc83xx_defconfig
sh                          rsk7264_defconfig
arc                     haps_hs_smp_defconfig
sh                           se7724_defconfig
powerpc                     ep8248e_defconfig
arm                         assabet_defconfig
arm                           corgi_defconfig
sh                               alldefconfig
powerpc                 mpc8272_ads_defconfig
sh                          sdk7780_defconfig
sh                           se7619_defconfig
mips                     cu1830-neo_defconfig
sh                           se7751_defconfig
arm                            lart_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                           se7721_defconfig
mips                        omega2p_defconfig
arm                            dove_defconfig
mips                          ath79_defconfig
powerpc                     kmeter1_defconfig
mips                      maltaaprp_defconfig
powerpc                      mgcoge_defconfig
arc                            hsdk_defconfig
xtensa                              defconfig
powerpc                      pmac32_defconfig
xtensa                         virt_defconfig
m68k                       m5475evb_defconfig
mips                         mpc30x_defconfig
h8300                               defconfig
openrisc                 simple_smp_defconfig
mips                         rt305x_defconfig
powerpc                     tqm8541_defconfig
c6x                        evmc6678_defconfig
powerpc                     tqm5200_defconfig
powerpc                      acadia_defconfig
arc                        nsimosci_defconfig
arm                           omap1_defconfig
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
i386                 randconfig-a004-20201208
i386                 randconfig-a005-20201208
i386                 randconfig-a001-20201208
i386                 randconfig-a002-20201208
i386                 randconfig-a006-20201208
i386                 randconfig-a003-20201208
x86_64               randconfig-a004-20201208
x86_64               randconfig-a006-20201208
x86_64               randconfig-a005-20201208
x86_64               randconfig-a001-20201208
x86_64               randconfig-a002-20201208
x86_64               randconfig-a003-20201208
i386                 randconfig-a013-20201208
i386                 randconfig-a014-20201208
i386                 randconfig-a011-20201208
i386                 randconfig-a015-20201208
i386                 randconfig-a012-20201208
i386                 randconfig-a016-20201208
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20201208
x86_64               randconfig-a013-20201208
x86_64               randconfig-a011-20201208
x86_64               randconfig-a016-20201208
x86_64               randconfig-a014-20201208
x86_64               randconfig-a015-20201208

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
