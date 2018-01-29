Return-Path: <linux-kernel@hansmi.ch>
Received: from s013.cyon.net (s013.cyon.net [149.126.4.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVlFB3YLSzDqH0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jan 2018 09:54:22 +1100 (AEDT)
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org,
	Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: [PATCH] Mark ams driver as orphaned in MAINTAINERS
Date: Mon, 29 Jan 2018 22:40:09 +0000
Message-Id: <8fe08e4d44c56ee0b70517fc8609ab5a116bc407.1517265227.git.linux-kernel@hansmi.ch>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I no longer have any hardware with the Apple motion sensor and thus
relinquish maintainership of the driver.

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a9c9c9ff7..6a07de631 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -780,8 +780,8 @@ F:	drivers/net/ethernet/amd/xgbe/
 F:	arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
 
 AMS (Apple Motion Sensor) DRIVER
-M:	Michael Hanselmann <linux-kernel@hansmi.ch>
-S:	Supported
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Orphan
 F:	drivers/macintosh/ams/
 
 ANALOG DEVICES INC AD9389B DRIVER
-- 
2.11.0
