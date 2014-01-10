Return-Path: <fengguang.wu@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by ozlabs.org (Postfix) with ESMTP id DC5C22C00B0
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Jan 2014 19:48:58 +1100 (EST)
Date: Fri, 10 Jan 2014 16:38:42 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: cuboot-pq2.c:undefined reference to `fsl_get_immr'
Message-ID: <20140110083842.GB32086@localhost>
References: <52cfaccd.zB+xVDXQN1I7DXJ2%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52cfaccd.zB+xVDXQN1I7DXJ2%fengguang.wu@intel.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>, kbuild-all@01.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Tony,

FYI, kernel build failed on

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7d1c153ab373a5c07feb97eaf4e4bcad5bfc262e
commit: b81f18e55e9f4ea81759bcb00fea295de679bbe8 powerpc/boot: Only build board support files when required.
date:   1 year, 6 months ago
config: make ARCH=powerpc storcenter_defconfig

All error/warnings:

   arch/powerpc/boot/cuboot-pq2.o: In function `pq2_platform_fixups':
>> cuboot-pq2.c:(.text+0x320): undefined reference to `fsl_get_immr'

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
