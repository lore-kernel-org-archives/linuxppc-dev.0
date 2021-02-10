Return-Path: <SRS0=uerg=HM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07466C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 05:44:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BAC664DE1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 05:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BAC664DE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Db7wr72pMzDvZG
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 16:43:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.136; helo=mga12.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Db7tv3FPczDsn6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2021 16:42:12 +1100 (AEDT)
IronPort-SDR: HklMMI8dHkykoRkXhNNLrZGdsmZ/4gXw3dzh4JQbvRFQ7x7dpDAyOl8orTPqHwswId8QXAyNj4
 x6z7rdFKdJow==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="161167353"
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; d="scan'208";a="161167353"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2021 21:42:10 -0800
IronPort-SDR: Djpc2SkW+m19jUzbo67iPzswcdJ10YXNa+2bBpR8j9/obCU06D82HfkpvLfP+REaNIRDegvN/w
 J81EQZYvXXxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; d="scan'208";a="586081523"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
 by fmsmga006.fm.intel.com with ESMTP; 09 Feb 2021 21:42:08 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1l9iGO-0002i1-65; Wed, 10 Feb 2021 05:42:08 +0000
Date: Wed, 10 Feb 2021 13:41:49 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [powerpc:merge] BUILD SUCCESS 393ff0ee1405c44af2720c953d1090b9bb8d0226
Message-ID: <6023721d.8+OprS3SjRR+yrUX%lkp@intel.com>
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
branch HEAD: 393ff0ee1405c44af2720c953d1090b9bb8d0226  Automatic merge of 'master' into merge (2021-02-07 21:53)

elapsed time: 1361m

configs tested: 125
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                       m5208evb_defconfig
sh                        edosk7760_defconfig
sparc                            alldefconfig
arm                         palmz72_defconfig
h8300                    h8300h-sim_defconfig
powerpc                      ep88xc_defconfig
arm                              zx_defconfig
x86_64                           alldefconfig
mips                          rb532_defconfig
powerpc                 mpc836x_mds_defconfig
sh                      rts7751r2d1_defconfig
powerpc                    klondike_defconfig
arm                           sunxi_defconfig
powerpc                    sam440ep_defconfig
nios2                               defconfig
m68k                        m5307c3_defconfig
m68k                       m5275evb_defconfig
xtensa                       common_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                       versatile_defconfig
powerpc                     stx_gp3_defconfig
sh                        sh7785lcr_defconfig
riscv                    nommu_k210_defconfig
mips                          rm200_defconfig
arm                       aspeed_g5_defconfig
powerpc                      bamboo_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                            zeus_defconfig
powerpc                     pq2fads_defconfig
mips                            e55_defconfig
powerpc                 mpc837x_rdb_defconfig
arc                        vdk_hs38_defconfig
mips                           rs90_defconfig
powerpc                     sequoia_defconfig
powerpc                     taishan_defconfig
mips                      maltaaprp_defconfig
arm                       cns3420vb_defconfig
alpha                            allyesconfig
sh                             shx3_defconfig
arm                          ixp4xx_defconfig
xtensa                  nommu_kc705_defconfig
arm                         hackkit_defconfig
m68k                       m5475evb_defconfig
arm                           stm32_defconfig
sh                          rsk7201_defconfig
h8300                     edosk2674_defconfig
powerpc                    socrates_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                      ppc40x_defconfig
m68k                          multi_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
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
x86_64               randconfig-a006-20210209
x86_64               randconfig-a001-20210209
x86_64               randconfig-a005-20210209
x86_64               randconfig-a004-20210209
x86_64               randconfig-a002-20210209
x86_64               randconfig-a003-20210209
i386                 randconfig-a001-20210209
i386                 randconfig-a005-20210209
i386                 randconfig-a003-20210209
i386                 randconfig-a002-20210209
i386                 randconfig-a006-20210209
i386                 randconfig-a004-20210209
i386                 randconfig-a016-20210209
i386                 randconfig-a013-20210209
i386                 randconfig-a012-20210209
i386                 randconfig-a014-20210209
i386                 randconfig-a011-20210209
i386                 randconfig-a015-20210209
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
x86_64               randconfig-a013-20210209
x86_64               randconfig-a014-20210209
x86_64               randconfig-a015-20210209
x86_64               randconfig-a012-20210209
x86_64               randconfig-a016-20210209
x86_64               randconfig-a011-20210209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
