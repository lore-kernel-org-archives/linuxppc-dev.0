Return-Path: <SRS0=5SgM=HY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B2DC433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Feb 2021 23:22:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47F2764E20
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Feb 2021 23:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F2764E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dkys65KQRz3cS0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Feb 2021 10:22:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dkyrl0p1tz30QK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2021 10:22:25 +1100 (AEDT)
IronPort-SDR: 8+lnsFdqV87kd3SkfkkMNcGWzsFmZbXaOtpM28w2pJ2A7n70yYYlofJBBhaAhe/P4aTDXkdvD6
 tpdjNioh7rhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="184743980"
X-IronPort-AV: E=Sophos;i="5.81,198,1610438400"; d="scan'208";a="184743980"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2021 15:22:21 -0800
IronPort-SDR: PEYzKPVKr57vvJwaA0l1BTkuAbP3GgeWCxYnCjwG7RFR+KKavfuzKReTYUZSSB+8jEtXaQkCq5
 55tzsZu57YPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,198,1610438400"; d="scan'208";a="403256792"
Received: from lkp-server01.sh.intel.com (HELO 16660e54978b) ([10.239.97.150])
 by orsmga007.jf.intel.com with ESMTP; 22 Feb 2021 15:22:20 -0800
Received: from kbuild by 16660e54978b with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lEKWx-0000ia-0L; Mon, 22 Feb 2021 23:22:19 +0000
Date: Tue, 23 Feb 2021 07:21:55 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [powerpc:merge] BUILD SUCCESS b267c8c58643460da9159ee69f46b3945cfd9de6
Message-ID: <60343c93.j77SpyOZQxZlE8oI%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git merge
branch HEAD: b267c8c58643460da9159ee69f46b3945cfd9de6  Automatic merge of 'master' into merge (2021-02-22 21:30)

elapsed time: 723m

configs tested: 123
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                           mtx1_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                        fsp2_defconfig
h8300                            alldefconfig
powerpc                        icon_defconfig
sh                           se7343_defconfig
ia64                            zx1_defconfig
arm                         shannon_defconfig
arm                        mvebu_v5_defconfig
powerpc                     kmeter1_defconfig
sh                         ecovec24_defconfig
powerpc                     redwood_defconfig
sh                         apsh4a3a_defconfig
powerpc                      ppc44x_defconfig
sh                          polaris_defconfig
powerpc                          g5_defconfig
mips                          malta_defconfig
arc                        nsim_700_defconfig
sh                           se7705_defconfig
powerpc                      chrp32_defconfig
ia64                        generic_defconfig
powerpc                      bamboo_defconfig
arm                          simpad_defconfig
arc                     nsimosci_hs_defconfig
arm                       netwinder_defconfig
arm                           spitz_defconfig
m68k                           sun3_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                     akebono_defconfig
mips                            ar7_defconfig
sparc                       sparc32_defconfig
ia64                      gensparse_defconfig
powerpc                     ppa8548_defconfig
powerpc                     mpc5200_defconfig
arm                     davinci_all_defconfig
mips                         tb0219_defconfig
arm                        keystone_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                      makalu_defconfig
powerpc                      walnut_defconfig
s390                             allyesconfig
mips                        jmr3927_defconfig
mips                      maltasmvp_defconfig
m68k                          multi_defconfig
arm                        realview_defconfig
powerpc                     taishan_defconfig
arm                          pxa168_defconfig
mips                           ci20_defconfig
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
s390                             allmodconfig
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
x86_64               randconfig-a001-20210222
x86_64               randconfig-a002-20210222
x86_64               randconfig-a003-20210222
x86_64               randconfig-a005-20210222
x86_64               randconfig-a006-20210222
x86_64               randconfig-a004-20210222
i386                 randconfig-a005-20210222
i386                 randconfig-a006-20210222
i386                 randconfig-a004-20210222
i386                 randconfig-a003-20210222
i386                 randconfig-a001-20210222
i386                 randconfig-a002-20210222
i386                 randconfig-a013-20210222
i386                 randconfig-a012-20210222
i386                 randconfig-a011-20210222
i386                 randconfig-a014-20210222
i386                 randconfig-a016-20210222
i386                 randconfig-a015-20210222
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210222
x86_64               randconfig-a011-20210222
x86_64               randconfig-a012-20210222
x86_64               randconfig-a016-20210222
x86_64               randconfig-a014-20210222
x86_64               randconfig-a013-20210222

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
