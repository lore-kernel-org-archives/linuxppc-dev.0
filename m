Return-Path: <justinmattock@gmail.com>
Received: from mail-yi0-f51.google.com (mail-yi0-f51.google.com
	[209.85.218.51]) by ozlabs.org (Postfix) with ESMTP id 328B510084B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Dec 2010 11:09:42 +1100 (EST)
Received: by yib12 with SMTP id 12so2621446yib.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Dec 2010 16:09:41 -0800 (PST)
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: trivial@kernel.org
Subject: [PATCH 3/5]drivers:staging:tidspbridge:core:tiomap3430.c Typo change
	singal to signal
Date: Thu, 30 Dec 2010 16:09:42 -0800
Message-Id: <1293754184-1928-3-git-send-email-justinmattock@gmail.com>
In-Reply-To: <1293754184-1928-2-git-send-email-justinmattock@gmail.com>
References: <1293754184-1928-1-git-send-email-justinmattock@gmail.com>
	<1293754184-1928-2-git-send-email-justinmattock@gmail.com>
Cc: gregkh@suse.de, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	"Justin P. Mattock" <justinmattock@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patches below fixes a typo "singal" to "signal". Please let me 
know if anything needs to be changed.

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
 drivers/staging/tidspbridge/core/tiomap3430.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430.c b/drivers/staging/tidspbridge/core/tiomap3430.c
index 1be081f..7e56ff6 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430.c
@@ -1796,7 +1796,7 @@ static int mem_map_vmalloc(struct bridge_dev_context *dev_context,
 
 /*
  *  ======== wait_for_start ========
- *      Wait for the singal from DSP that it has started, or time out.
+ *      Wait for the signal from DSP that it has started, or time out.
  */
 bool wait_for_start(struct bridge_dev_context *dev_context, u32 dw_sync_addr)
 {
-- 
1.6.5.2.180.gc5b3e
