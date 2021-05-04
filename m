Return-Path: <SRS0=2Civ=J7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9F9C433B4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 May 2021 02:51:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C9DF61185
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 May 2021 02:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9DF61185
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FZ49D71Dzz304L
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 May 2021 12:51:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FZ47y32WKz2y6N
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 May 2021 12:49:59 +1000 (AEST)
IronPort-SDR: OApuum/CbN7y3AOdFHw0t+cJsVq4LaLpuO2F5YpJgYCYrTuOWhPAHp3BOUj6DRfKjPGxLjymjk
 uBLc+MuxG68g==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="197973785"
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; d="scan'208";a="197973785"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 May 2021 19:49:55 -0700
IronPort-SDR: ngNJAWrwKFzZPwtVDUGZIpoF8+xI75vrAj8z7mpxC54ZIVN/QVvN9bVZiQ/uxWO7qbbQsdn19B
 JLZ5b/sRQN9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; d="scan'208";a="539008060"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
 by orsmga004.jf.intel.com with ESMTP; 03 May 2021 19:49:54 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1ldl8D-0009R1-Pq; Tue, 04 May 2021 02:49:53 +0000
Date: Tue, 04 May 2021 10:49:19 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [powerpc:next] BUILD SUCCESS 562d1e207d322e6346e8db91bbd11d94f16427d2
Message-ID: <6090b62f.Y3jjI1G2L6e+4rK3%lkp@intel.com>
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
branch HEAD: 562d1e207d322e6346e8db91bbd11d94f16427d2  powerpc/powernv: remove the nvlink support

elapsed time: 726m

configs tested: 44
configs skipped: 78

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
mips                         tb0219_defconfig
mips                           ip27_defconfig
sh                        apsh4ad0a_defconfig
riscv                             allnoconfig
arm                        neponset_defconfig
arm                             pxa_defconfig
arm                        clps711x_defconfig
m68k                       m5475evb_defconfig
mips                     loongson1c_defconfig
arm                          exynos_defconfig
arm                                 defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210503
i386                 randconfig-a006-20210503
i386                 randconfig-a001-20210503
i386                 randconfig-a005-20210503
i386                 randconfig-a004-20210503
i386                 randconfig-a002-20210503
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig

clang tested configs:
x86_64               randconfig-a014-20210503
x86_64               randconfig-a015-20210503
x86_64               randconfig-a012-20210503
x86_64               randconfig-a011-20210503
x86_64               randconfig-a013-20210503
x86_64               randconfig-a016-20210503

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
