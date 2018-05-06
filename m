Return-Path: <wsa+renesas@sang-engineering.com>
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by lists.ozlabs.org (Postfix) with ESMTP id 40f3L85PM3zF0Pl
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 May 2018 21:24:12 +1000 (AEST)
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: trivial@kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 reiserfs-devel@vger.kernel.org
Subject: [PATCH 0/9] tree-wide: fix typo 'can by' to 'can be'
Date: Sun,  6 May 2018 13:23:44 +0200
Message-Id: <20180506112404.24872-1-wsa+renesas@sang-engineering.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I found this kind of typo when reading the documentation for device_remove().
So, I checked the tree for it.

CCing all the subsystems directly, and I'd think the leftover ones could be
picked up by the trivial tree. Or would it be more convenient if trivial would
pick up all? I don't mind.

Based on v4.17-rc3.

Wolfram Sang (9):
  dt-bindings: i2c: fix typo 'can by' to 'can be'
  powerpc/watchdog: fix typo 'can by' to 'can be'
  base: core: fix typo 'can by' to 'can be'
  hwmon: fschmd: fix typo 'can by' to 'can be'
  input: ati_remote2: fix typo 'can by' to 'can be'
  NTB: ntb_hw_idt: fix typo 'can by' to 'can be'
  reiserfs: journal: fix typo 'can by' to 'can be'
  net: flow_dissector: fix typo 'can by' to 'can be'
  objtool: fix typo 'can by' to 'can be'

 Documentation/devicetree/bindings/i2c/i2c-davinci.txt | 2 +-
 arch/powerpc/kernel/watchdog.c                        | 2 +-
 drivers/base/core.c                                   | 2 +-
 drivers/hwmon/fschmd.c                                | 2 +-
 drivers/input/misc/ati_remote2.c                      | 2 +-
 drivers/ntb/hw/idt/ntb_hw_idt.c                       | 2 +-
 fs/reiserfs/journal.c                                 | 2 +-
 include/net/flow_dissector.h                          | 2 +-
 tools/objtool/Documentation/stack-validation.txt      | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.11.0
