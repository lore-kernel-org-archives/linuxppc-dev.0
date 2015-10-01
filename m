Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by lists.ozlabs.org (Postfix) with ESMTP id B15AC1A010A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 19:46:16 +1000 (AEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/5] powerpc/pseries: bug fix and clean up
Date: Thu,  1 Oct 2015 12:46:05 +0300
Message-Id: <1443692770-44944-1-git-send-email-andriy.shevchenko@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Changelog v2:
 - fix compiler error
 - rebase on top of recent linux-next
 - compile tested

Andy Shevchenko (5):
  powerpc/pseries: extract of_helpers module
  powerpc/pseries: fix a potential memory leak
  powerpc/pseries: replace kmalloc + strlcpy
  powerpc/pseries: handle nodes without '/'
  powerpc/pseries: re-use code from of_helpers module

 arch/powerpc/platforms/pseries/Makefile     |  1 +
 arch/powerpc/platforms/pseries/dlpar.c      | 31 +++++--------------------
 arch/powerpc/platforms/pseries/of_helpers.c | 35 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/of_helpers.h |  8 +++++++
 arch/powerpc/platforms/pseries/reconfig.c   | 34 ++--------------------------
 5 files changed, 51 insertions(+), 58 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/of_helpers.c
 create mode 100644 arch/powerpc/platforms/pseries/of_helpers.h

-- 
2.5.1
