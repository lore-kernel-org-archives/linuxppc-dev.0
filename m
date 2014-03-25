Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0216.hostedemail.com
 [216.40.44.216]) by ozlabs.org (Postfix) with ESMTP id C898C140086
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 06:35:14 +1100 (EST)
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Convert last few uses of __FUNCTION__ to __func__
Date: Tue, 25 Mar 2014 12:35:02 -0700
Message-Id: <cover.1395775901.git.joe@perches.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, xen-devel@lists.xenproject.org,
 linuxppc-dev@lists.ozlabs.org, drbd-user@lists.linbit.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Outside of staging, there aren't any more uses of __FUNCTION__ now...

Joe Perches (5):
  powerpc: Convert last uses of __FUNCTION__ to __func__
  x86: Convert last uses of __FUNCTION__ to __func__
  block: Convert last uses of __FUNCTION__ to __func__
  i915: Convert last uses of __FUNCTION__ to __func__
  slab: Convert last uses of __FUNCTION__ to __func__

 arch/powerpc/platforms/pseries/nvram.c       | 11 +++++------
 arch/x86/kernel/hpet.c                       |  2 +-
 arch/x86/kernel/rtc.c                        |  4 ++--
 arch/x86/platform/intel-mid/intel_mid_vrtc.c |  2 +-
 drivers/block/drbd/drbd_int.h                |  8 ++++----
 drivers/block/xen-blkfront.c                 |  4 ++--
 drivers/gpu/drm/i915/dvo_ns2501.c            | 15 ++++++---------
 mm/slab.h                                    |  2 +-
 8 files changed, 22 insertions(+), 26 deletions(-)

-- 
1.8.1.2.459.gbcd45b4.dirty
