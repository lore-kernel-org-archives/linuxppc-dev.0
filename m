Return-Path: <luisbg@osg.samsung.com>
Received: from lists.s-osg.org (lists.s-osg.org [54.187.51.154])
 by lists.ozlabs.org (Postfix) with ESMTP id 057C51A01B2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 02:04:13 +1100 (AEDT)
From: Luis de Bethencourt <luisbg@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, paulus@samba.org,
 benh@kernel.crashing.org, agust@denx.de, axboe@fb.com, jack@suse.cz,
 dan.j.williams@intel.com, matthew.r.wilcox@intel.com, neilb@suse.com,
 ross.zwisler@linux.intel.com, Luis de Bethencourt <luisbg@osg.samsung.com>
Subject: [RESEND PATCH 0/2] powerpc: Fix module autoload for OF platform
 drivers
Date: Tue, 20 Oct 2015 16:04:11 +0100
Message-Id: <1445353453-846-1-git-send-email-luisbg@osg.samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This is a resend of this patch series. It was posted on September 18 [0]

These patches add the missing MODULE_DEVICE_TABLE() for OF to export
the information so modules have the correct aliases built-in and
autoloading works correctly.

A longer explanation by Javier Canillas can be found here:
https://lkml.org/lkml/2015/7/30/519

Thanks,
Luis

[0] https://lkml.org/lkml/2015/9/18/749
[1] https://lkml.org/lkml/2015/9/18/750
[2] https://lkml.org/lkml/2015/9/18/752

Luis de Bethencourt (2):
  powerpc: platforms: mpc52xx_lpbfifo: Fix module autoload for OF
    platform driver
  powerpc: axonram: Fix module autoload for OF platform driver

 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c | 1 +
 arch/powerpc/sysdev/axonram.c                 | 1 +
 2 files changed, 2 insertions(+)

-- 
2.5.3
