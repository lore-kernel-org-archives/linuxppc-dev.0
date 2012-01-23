Return-Path: <iida@rinabert.homeip.net>
Received: from rinabert.homeip.net (i118-21-156-233.s30.a048.ap.plala.or.jp
 [118.21.156.233])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9C927B6EEA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2012 01:27:44 +1100 (EST)
From: Masanari Iida <standby24x7@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org
Subject: [PATCH 1/2] [trivial] macintosh: Fix typo in mediabay.c
Date: Tue, 24 Jan 2012 02:26:36 +0900
Message-Id: <1327339596-3503-1-git-send-email-standby24x7@gmail.com>
Cc: standby24x7@gmail.com, trivial@kernel.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix typo "unsuported" to "unsupported" in
drivers/machintosh/mediabay.c

Signed-off-by: Masanari Iida<standby24x7@gmail.com>
---
 drivers/macintosh/mediabay.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/macintosh/mediabay.c b/drivers/macintosh/mediabay.c
index 2fd435b..831d751 100644
--- a/drivers/macintosh/mediabay.c
+++ b/drivers/macintosh/mediabay.c
@@ -356,7 +356,7 @@ static void poll_media_bay(struct media_bay_info* bay)
 	static char *mb_content_types[] = {
 		"a floppy drive",
 		"a floppy drive",
-		"an unsuported audio device",
+		"an unsupported audio device",
 		"an ATA device",
 		"an unsupported PCI device",
 		"an unknown device",
-- 
1.7.6.5
