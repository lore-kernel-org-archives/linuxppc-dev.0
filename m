Return-Path: <SRS0=Y7Jt=72=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04106C433DF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Jun 2020 06:54:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD092071A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Jun 2020 06:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD092071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49kSy76YJ5zDr1q
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Jun 2020 16:54:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49kSrp6rnXzDqH4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2020 16:50:02 +1000 (AEST)
IronPort-SDR: OBxjyJ9X8glKaK/PKFNbPsnHbvC/liqc1J5FwHYV1Gfzoe3NIOf3G0CeP7qyFTBHf0Cn75V4bm
 cHm0ZMesB00w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2020 23:50:00 -0700
IronPort-SDR: cR4j71484FqJ4f/x7bvW7HlvwQOBATQ5iT6Dh1KlLvggknOjSM4Eg9AYDPDcJOJ99WK2g06jzO
 vkO7ULAf3jQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,506,1583222400"; d="scan'208";a="275968524"
Received: from lkp-server02.sh.intel.com (HELO de5642daf266) ([10.239.97.151])
 by orsmga006.jf.intel.com with ESMTP; 12 Jun 2020 23:49:59 -0700
Received: from kbuild by de5642daf266 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1jjzzL-0000Fw-1X; Sat, 13 Jun 2020 06:49:59 +0000
Date: Sat, 13 Jun 2020 14:49:28 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [powerpc:merge] BUILD SUCCESS 062ce06f9dcd140b6cd97102fec593a57c5fb397
Message-ID: <5ee476f8.aMWdZzXc8x+X4utU%lkp@intel.com>
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
branch HEAD: 062ce06f9dcd140b6cd97102fec593a57c5fb397  Automatic merge of 'master', 'next' and 'fixes' (2020-06-13 08:10)

elapsed time: 511m

configs tested: 142
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                            zeus_defconfig
arm                         socfpga_defconfig
parisc                generic-64bit_defconfig
mips                        qi_lb60_defconfig
arm                             ezx_defconfig
arm                          pxa168_defconfig
xtensa                         virt_defconfig
arm                          moxart_defconfig
arm                              zx_defconfig
sh                   sh7770_generic_defconfig
arm                          imote2_defconfig
arm                        clps711x_defconfig
sh                 kfr2r09-romimage_defconfig
arc                 nsimosci_hs_smp_defconfig
xtensa                          iss_defconfig
riscv                          rv32_defconfig
c6x                        evmc6474_defconfig
sh                          urquell_defconfig
powerpc                    amigaone_defconfig
microblaze                          defconfig
arm                          lpd270_defconfig
um                           x86_64_defconfig
arm                         s3c6400_defconfig
sh                ecovec24-romimage_defconfig
c6x                         dsk6455_defconfig
arm                      tct_hammer_defconfig
arm                       aspeed_g5_defconfig
sh                         microdev_defconfig
mips                      bmips_stb_defconfig
mips                           ip22_defconfig
s390                       zfcpdump_defconfig
arc                        vdk_hs38_defconfig
arc                           tb10x_defconfig
openrisc                         allyesconfig
sparc                            allyesconfig
arm                          pxa910_defconfig
mips                         cobalt_defconfig
microblaze                    nommu_defconfig
arm                  colibri_pxa300_defconfig
m68k                          atari_defconfig
arc                        nsim_700_defconfig
arm                           efm32_defconfig
powerpc                     pq2fads_defconfig
arm                          tango4_defconfig
c6x                        evmc6472_defconfig
arm                          ixp4xx_defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
x86_64               randconfig-a001-20200612
x86_64               randconfig-a003-20200612
x86_64               randconfig-a002-20200612
x86_64               randconfig-a006-20200612
x86_64               randconfig-a005-20200612
x86_64               randconfig-a004-20200612
i386                 randconfig-a006-20200612
i386                 randconfig-a002-20200612
i386                 randconfig-a001-20200612
i386                 randconfig-a004-20200612
i386                 randconfig-a005-20200612
i386                 randconfig-a003-20200612
i386                 randconfig-a015-20200612
i386                 randconfig-a011-20200612
i386                 randconfig-a014-20200612
i386                 randconfig-a016-20200612
i386                 randconfig-a013-20200612
i386                 randconfig-a012-20200612
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                                  defconfig
um                               allyesconfig
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
