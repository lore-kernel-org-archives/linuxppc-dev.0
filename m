Return-Path: <SRS0=wZlq=MS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BF1C4338F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 02:34:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B064D60E78
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 02:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B064D60E78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GY3t81bgtz3bSs
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Jul 2021 12:34:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.136; helo=mga12.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GY3sk1Q1kz2yX1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jul 2021 12:34:29 +1000 (AEST)
X-IronPort-AV: E=McAfee;i="6200,9189,10056"; a="191736789"
X-IronPort-AV: E=Sophos;i="5.84,269,1620716400"; d="scan'208";a="191736789"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2021 19:33:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,269,1620716400"; d="scan'208";a="664366862"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
 by fmsmga005.fm.intel.com with ESMTP; 25 Jul 2021 19:33:25 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1m7qQm-00054a-Cr; Mon, 26 Jul 2021 02:33:24 +0000
Date: Mon, 26 Jul 2021 10:33:07 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [powerpc:fixes-test] BUILD SUCCESS
 d9c57d3ed52a92536f5fa59dc5ccdd58b4875076
Message-ID: <60fe1ee3.jrLrda9/YBtnfSDC%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git fixes-test
branch HEAD: d9c57d3ed52a92536f5fa59dc5ccdd58b4875076  KVM: PPC: Book3S HV Nested: Sanitise H_ENTER_NESTED TM state

elapsed time: 724m

configs tested: 158
configs skipped: 99

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                 randconfig-c001-20210725
i386                 randconfig-c001-20210726
arm                             pxa_defconfig
arm                        spear6xx_defconfig
mips                           mtx1_defconfig
powerpc                      cm5200_defconfig
arm                            dove_defconfig
powerpc                 mpc85xx_cds_defconfig
x86_64                            allnoconfig
h8300                       h8s-sim_defconfig
powerpc                    mvme5100_defconfig
mips                           rs90_defconfig
alpha                               defconfig
ia64                         bigsur_defconfig
openrisc                 simple_smp_defconfig
sh                             sh03_defconfig
powerpc                     rainier_defconfig
arm                          ixp4xx_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                   microwatt_defconfig
powerpc                     akebono_defconfig
sh                           se7206_defconfig
m68k                          atari_defconfig
m68k                          sun3x_defconfig
mips                        jmr3927_defconfig
mips                          ath79_defconfig
powerpc                      mgcoge_defconfig
um                           x86_64_defconfig
powerpc                          g5_defconfig
microblaze                          defconfig
mips                        nlm_xlp_defconfig
powerpc                           allnoconfig
mips                       bmips_be_defconfig
powerpc                      ppc40x_defconfig
mips                  decstation_64_defconfig
sh                            migor_defconfig
powerpc64                        alldefconfig
powerpc                      obs600_defconfig
sh                     sh7710voipgw_defconfig
sh                          rsk7203_defconfig
nios2                            allyesconfig
powerpc                     ep8248e_defconfig
parisc                generic-32bit_defconfig
riscv             nommu_k210_sdcard_defconfig
ia64                            zx1_defconfig
powerpc                     pseries_defconfig
riscv                    nommu_virt_defconfig
powerpc                  storcenter_defconfig
mips                    maltaup_xpa_defconfig
mips                         cobalt_defconfig
sh                           se7780_defconfig
arm                          pcm027_defconfig
xtensa                              defconfig
h8300                            alldefconfig
powerpc                     ksi8560_defconfig
m68k                        stmark2_defconfig
powerpc                     tqm8541_defconfig
powerpc                      ep88xc_defconfig
sh                         apsh4a3a_defconfig
powerpc                     sequoia_defconfig
xtensa                          iss_defconfig
mips                      pistachio_defconfig
sh                          landisk_defconfig
arc                        nsim_700_defconfig
powerpc                 mpc834x_mds_defconfig
sparc64                          alldefconfig
arm                        magician_defconfig
powerpc                  iss476-smp_defconfig
nios2                               defconfig
sh                         ap325rxa_defconfig
mips                      malta_kvm_defconfig
m68k                         amcore_defconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a005-20210725
i386                 randconfig-a003-20210725
i386                 randconfig-a004-20210725
i386                 randconfig-a002-20210725
i386                 randconfig-a001-20210725
i386                 randconfig-a006-20210725
i386                 randconfig-a005-20210726
i386                 randconfig-a003-20210726
i386                 randconfig-a004-20210726
i386                 randconfig-a002-20210726
i386                 randconfig-a001-20210726
i386                 randconfig-a006-20210726
x86_64               randconfig-a011-20210725
x86_64               randconfig-a016-20210725
x86_64               randconfig-a013-20210725
x86_64               randconfig-a014-20210725
x86_64               randconfig-a012-20210725
x86_64               randconfig-a015-20210725
i386                 randconfig-a016-20210725
i386                 randconfig-a013-20210725
i386                 randconfig-a012-20210725
i386                 randconfig-a014-20210725
i386                 randconfig-a011-20210725
i386                 randconfig-a015-20210725
i386                 randconfig-a016-20210726
i386                 randconfig-a013-20210726
i386                 randconfig-a012-20210726
i386                 randconfig-a011-20210726
i386                 randconfig-a014-20210726
i386                 randconfig-a015-20210726
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210726
x86_64               randconfig-c001-20210725
x86_64               randconfig-a003-20210725
x86_64               randconfig-a006-20210725
x86_64               randconfig-a001-20210725
x86_64               randconfig-a005-20210725
x86_64               randconfig-a004-20210725
x86_64               randconfig-a002-20210725
x86_64               randconfig-a011-20210726
x86_64               randconfig-a013-20210726
x86_64               randconfig-a014-20210726
x86_64               randconfig-a012-20210726
x86_64               randconfig-a015-20210726

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
