Return-Path: <fengguang.wu@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by ozlabs.org (Postfix) with ESMTP id 2E8332C0087
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 16:27:10 +1100 (EST)
Date: Thu, 15 Nov 2012 13:26:28 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: [powerpc:dt 10/10]
 lib/pSeries-reconfig-notifier-error-inject.c:4:34: fatal error:
 asm/pSeries_reconfig.h: No such file or directory
Message-ID: <50a47d04.6N+SxZ6/xKVFPteg%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git dt
head:   f459d63e1689b16a2f5a965557e19b25bad5dbdc
commit: f459d63e1689b16a2f5a965557e19b25bad5dbdc [10/10] powerpc+of: Remove the pSeries_reconfig.h file
config: make ARCH=powerpc allmodconfig

All error/warnings:

lib/pSeries-reconfig-notifier-error-inject.c:4:34: fatal error: asm/pSeries_reconfig.h: No such file or directory
compilation terminated.

vim +4 lib/pSeries-reconfig-notifier-error-inject.c

08dfb4dd Akinobu Mita 2012-07-30   1  #include <linux/kernel.h>
08dfb4dd Akinobu Mita 2012-07-30   2  #include <linux/module.h>
08dfb4dd Akinobu Mita 2012-07-30   3  
08dfb4dd Akinobu Mita 2012-07-30  @4  #include <asm/pSeries_reconfig.h>
08dfb4dd Akinobu Mita 2012-07-30   5  
08dfb4dd Akinobu Mita 2012-07-30   6  #include "notifier-error-inject.h"
08dfb4dd Akinobu Mita 2012-07-30   7  
08dfb4dd Akinobu Mita 2012-07-30   8  static int priority;
08dfb4dd Akinobu Mita 2012-07-30   9  module_param(priority, int, 0);
08dfb4dd Akinobu Mita 2012-07-30  10  MODULE_PARM_DESC(priority, "specify pSeries reconfig notifier priority");
08dfb4dd Akinobu Mita 2012-07-30  11  
08dfb4dd Akinobu Mita 2012-07-30  12  static struct notifier_err_inject reconfig_err_inject = {

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
