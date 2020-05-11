Return-Path: <SRS0=5PiN=6Z=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04290C47255
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2020 08:29:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF1EA207DD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2020 08:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1EA207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49LDcM3gXSzDqZR
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2020 18:29:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.126; helo=mga18.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49LDWy3hrBzDqZQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2020 18:25:13 +1000 (AEST)
IronPort-SDR: GbZD8KFUn3p6epANDfAojs0xBVxTt4ZG004iOoBzV6SHg6pNSax6ue3eTJgUop7Ix85STDHLm6
 qJOyd884XG5w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2020 01:25:09 -0700
IronPort-SDR: +5gpJJKxUHbEg8SyrdctV4sZ1W9fmKN0uakAmT5fAeTbi/SOkU8sSfAkYoGQmeqVZyA718wBTn
 aurYR3PCYcOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,379,1583222400"; d="scan'208";a="261695736"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by orsmga003.jf.intel.com with ESMTP; 11 May 2020 01:25:08 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1jY3kJ-00014W-Vs; Mon, 11 May 2020 16:25:07 +0800
Date: Mon, 11 May 2020 16:25:02 +0800
From: kbuild test robot <lkp@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [powerpc:topic/ppc-kvm] BUILD SUCCESS
 b1f9be9392f090f08e4ad9e2c68963aeff03bd67
Message-ID: <5eb90bde./qWf7vpM95UKw/32%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git  topic/ppc-kvm
branch HEAD: b1f9be9392f090f08e4ad9e2c68963aeff03bd67  powerpc/xive: Enforce load-after-store ordering when StoreEOI is active

elapsed time: 484m

configs tested: 95
configs skipped: 71

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
sparc                            allyesconfig
m68k                             allyesconfig
parisc                           allyesconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
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
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20200511
i386                 randconfig-a005-20200511
i386                 randconfig-a003-20200511
i386                 randconfig-a001-20200511
i386                 randconfig-a004-20200511
i386                 randconfig-a002-20200511
i386                 randconfig-a012-20200510
i386                 randconfig-a016-20200510
i386                 randconfig-a014-20200510
i386                 randconfig-a011-20200510
i386                 randconfig-a013-20200510
i386                 randconfig-a015-20200510
i386                 randconfig-a012-20200511
i386                 randconfig-a016-20200511
i386                 randconfig-a014-20200511
i386                 randconfig-a011-20200511
i386                 randconfig-a013-20200511
i386                 randconfig-a015-20200511
x86_64               randconfig-a005-20200511
x86_64               randconfig-a003-20200511
x86_64               randconfig-a006-20200511
x86_64               randconfig-a004-20200511
x86_64               randconfig-a001-20200511
x86_64               randconfig-a002-20200511
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
sparc                               defconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
