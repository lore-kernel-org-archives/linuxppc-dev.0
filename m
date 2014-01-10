Return-Path: <fengguang.wu@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by ozlabs.org (Postfix) with ESMTP id 564AA2C009C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2014 15:36:49 +1100 (EST)
Date: Fri, 10 Jan 2014 12:36:42 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: warning: (PPC_PSERIES && ..) selects HOTPLUG_CPU which has unmet
 direct dependencies (SMP && ..))
Message-ID: <20140110043642.GB21058@localhost>
References: <52cebbdf.VOHKy5gPVEgnVPcm%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52cebbdf.VOHKy5gPVEgnVPcm%fengguang.wu@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, kbuild-all@01.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7d1c153ab373a5c07feb97eaf4e4bcad5bfc262e
commit: bb07b00be77fb33274cb44a03bdbf2471e556189 Merge 3.10-rc6 into driver-core-next
date:   7 months ago
config: make ARCH=powerpc mpc86xx_defconfig

All warnings:

warning: (PPC_PSERIES && PM_SLEEP_SMP) selects HOTPLUG_CPU which has unmet direct dependencies (SMP && (PPC_PSERIES || PPC_PMAC || PPC_POWERNV || PPC_85xx && !PPC_E500MC))

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
