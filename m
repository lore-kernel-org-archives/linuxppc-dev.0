Return-Path: <SRS0=jJTS=3Y=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556F9C3524A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Feb 2020 03:55:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9832B2087E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Feb 2020 03:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9832B2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48BW6y2S7xzDqRR
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Feb 2020 14:55:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48BW5G5ZvHzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Feb 2020 14:53:33 +1100 (AEDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Feb 2020 19:53:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,398,1574150400"; d="scan'208";a="234978939"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by orsmga006.jf.intel.com with ESMTP; 03 Feb 2020 19:53:27 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1iypHC-000Cfg-GD; Tue, 04 Feb 2020 11:53:26 +0800
Date: Tue, 04 Feb 2020 11:52:28 +0800
From: kbuild test robot <lkp@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [powerpc:next-test] BUILD SUCCESS
 4c25df5640ae6e4491ee2c50d3f70c1559ef037d
Message-ID: <5e38ea7c.LdU3RpLHiElO6a9J%lkp@intel.com>
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

tree/branch: https://github.com/linuxppc/linux  next-test
branch HEAD: 4c25df5640ae6e4491ee2c50d3f70c1559ef037d  Merge branch 'topic/user-access-begin' into next

elapsed time: 3868m

configs tested: 265
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
sparc                            allyesconfig
riscv                            allyesconfig
riscv                          rv32_defconfig
ia64                                defconfig
s390                             allmodconfig
alpha                               defconfig
riscv                               defconfig
s390                          debug_defconfig
xtensa                          iss_defconfig
ia64                             alldefconfig
parisc                         b180_defconfig
parisc                              defconfig
i386                                defconfig
s390                             allyesconfig
m68k                           sun3_defconfig
i386                              allnoconfig
openrisc                 simple_smp_defconfig
nds32                               defconfig
i386                             alldefconfig
i386                             allyesconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
xtensa                       common_defconfig
openrisc                    or1ksim_defconfig
nios2                         3c120_defconfig
c6x                        evmc6678_defconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
csky                                defconfig
nds32                             allnoconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
h8300                    h8300h-sim_defconfig
h8300                     edosk2674_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                            allyesonfig
parisc                        c3000_defconfig
x86_64               randconfig-a001-20200202
x86_64               randconfig-a002-20200202
x86_64               randconfig-a003-20200202
i386                 randconfig-a001-20200202
i386                 randconfig-a002-20200202
i386                 randconfig-a003-20200202
x86_64               randconfig-a001-20200203
x86_64               randconfig-a002-20200203
i386                 randconfig-a001-20200203
i386                 randconfig-a003-20200203
alpha                randconfig-a001-20200203
m68k                 randconfig-a001-20200203
mips                 randconfig-a001-20200203
nds32                randconfig-a001-20200203
parisc               randconfig-a001-20200203
riscv                randconfig-a001-20200203
alpha                randconfig-a001-20200202
m68k                 randconfig-a001-20200202
nds32                randconfig-a001-20200202
parisc               randconfig-a001-20200202
riscv                randconfig-a001-20200202
mips                 randconfig-a001-20200202
c6x                  randconfig-a001-20200203
h8300                randconfig-a001-20200203
microblaze           randconfig-a001-20200203
nios2                randconfig-a001-20200203
sparc64              randconfig-a001-20200203
h8300                randconfig-a001-20200201
nios2                randconfig-a001-20200201
sparc64              randconfig-a001-20200201
c6x                  randconfig-a001-20200201
c6x                  randconfig-a001-20200202
h8300                randconfig-a001-20200202
microblaze           randconfig-a001-20200202
nios2                randconfig-a001-20200202
sparc64              randconfig-a001-20200202
csky                 randconfig-a001-20200202
openrisc             randconfig-a001-20200202
s390                 randconfig-a001-20200202
sh                   randconfig-a001-20200202
xtensa               randconfig-a001-20200202
sh                   randconfig-a001-20200201
s390                 randconfig-a001-20200201
csky                 randconfig-a001-20200201
xtensa               randconfig-a001-20200201
openrisc             randconfig-a001-20200201
csky                 randconfig-a001-20200203
openrisc             randconfig-a001-20200203
s390                 randconfig-a001-20200203
sh                   randconfig-a001-20200203
xtensa               randconfig-a001-20200203
x86_64               randconfig-b001-20200203
x86_64               randconfig-b002-20200203
x86_64               randconfig-b003-20200203
i386                 randconfig-b001-20200203
i386                 randconfig-b002-20200203
i386                 randconfig-b003-20200203
x86_64               randconfig-b001-20200202
x86_64               randconfig-b002-20200202
x86_64               randconfig-b003-20200202
i386                 randconfig-b001-20200202
i386                 randconfig-b002-20200202
i386                 randconfig-b003-20200202
x86_64               randconfig-b001-20200204
x86_64               randconfig-b002-20200204
x86_64               randconfig-b003-20200204
i386                 randconfig-b001-20200204
i386                 randconfig-b002-20200204
i386                 randconfig-b003-20200204
x86_64               randconfig-c001-20200202
x86_64               randconfig-c002-20200202
x86_64               randconfig-c003-20200202
i386                 randconfig-c001-20200202
i386                 randconfig-c002-20200202
i386                 randconfig-c003-20200202
x86_64               randconfig-c003-20200201
i386                 randconfig-c002-20200201
x86_64               randconfig-c002-20200201
i386                 randconfig-c001-20200201
x86_64               randconfig-c001-20200201
i386                 randconfig-c003-20200201
x86_64               randconfig-c001-20200203
x86_64               randconfig-c002-20200203
x86_64               randconfig-c003-20200203
i386                 randconfig-c001-20200203
i386                 randconfig-c002-20200203
i386                 randconfig-c003-20200203
x86_64               randconfig-c001-20200204
x86_64               randconfig-c002-20200204
x86_64               randconfig-c003-20200204
i386                 randconfig-c001-20200204
i386                 randconfig-c002-20200204
i386                 randconfig-c003-20200204
x86_64               randconfig-d001-20200202
x86_64               randconfig-d002-20200202
x86_64               randconfig-d003-20200202
i386                 randconfig-d001-20200202
i386                 randconfig-d002-20200202
i386                 randconfig-d003-20200202
x86_64               randconfig-e001-20200202
x86_64               randconfig-e002-20200202
x86_64               randconfig-e003-20200202
i386                 randconfig-e001-20200202
i386                 randconfig-e002-20200202
i386                 randconfig-e003-20200202
i386                 randconfig-e003-20200201
i386                 randconfig-e002-20200201
x86_64               randconfig-e001-20200201
x86_64               randconfig-e003-20200201
i386                 randconfig-e001-20200201
x86_64               randconfig-e002-20200201
x86_64               randconfig-f001-20200202
x86_64               randconfig-f002-20200202
x86_64               randconfig-f003-20200202
i386                 randconfig-f001-20200202
i386                 randconfig-f002-20200202
i386                 randconfig-f003-20200202
x86_64               randconfig-g003-20200201
x86_64               randconfig-g001-20200201
i386                 randconfig-g001-20200201
x86_64               randconfig-g002-20200201
i386                 randconfig-g002-20200201
i386                 randconfig-g003-20200201
x86_64               randconfig-g001-20200202
x86_64               randconfig-g002-20200202
x86_64               randconfig-g003-20200202
i386                 randconfig-g001-20200202
i386                 randconfig-g002-20200202
i386                 randconfig-g003-20200202
x86_64               randconfig-h001-20200202
x86_64               randconfig-h002-20200202
x86_64               randconfig-h003-20200202
i386                 randconfig-h001-20200202
i386                 randconfig-h002-20200202
i386                 randconfig-h003-20200202
x86_64               randconfig-h001-20200203
x86_64               randconfig-h002-20200203
x86_64               randconfig-h003-20200203
i386                 randconfig-h001-20200203
i386                 randconfig-h002-20200203
i386                 randconfig-h003-20200203
x86_64               randconfig-h001-20200204
x86_64               randconfig-h002-20200204
x86_64               randconfig-h003-20200204
i386                 randconfig-h001-20200204
i386                 randconfig-h002-20200204
i386                 randconfig-h003-20200204
x86_64               randconfig-h001-20200201
i386                 randconfig-h002-20200201
x86_64               randconfig-h002-20200201
i386                 randconfig-h003-20200201
x86_64               randconfig-h003-20200201
i386                 randconfig-h001-20200201
ia64                 randconfig-a001-20200203
arm                  randconfig-a001-20200203
arc                  randconfig-a001-20200203
arm64                randconfig-a001-20200203
powerpc              randconfig-a001-20200203
sparc                randconfig-a001-20200203
powerpc              randconfig-a001-20200202
arc                  randconfig-a001-20200202
ia64                 randconfig-a001-20200202
sparc                randconfig-a001-20200202
arm64                randconfig-a001-20200202
arm                  randconfig-a001-20200202
arc                  randconfig-a001-20200201
ia64                 randconfig-a001-20200201
sparc                randconfig-a001-20200201
arm64                randconfig-a001-20200201
arm                  randconfig-a001-20200201
riscv                            allmodconfig
riscv                             allnoconfig
riscv                    nommu_virt_defconfig
s390                             alldefconfig
s390                              allnoconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
