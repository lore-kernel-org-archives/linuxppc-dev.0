Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail58-dub-R.bigfish.com (mail-dub.bigfish.com [213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 24DE4DDFFD
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 07:34:12 +1100 (EST)
Message-ID: <47910CC4.5060400@am.sony.com>
Date: Fri, 18 Jan 2008 12:32:04 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 06/16] PS3: Kill unused ps3_repository_bump_device()
References: <20080118202612.422185192@am.sony.com>
In-Reply-To: <20080118202612.422185192@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

PS3: Kill unused routine ps3_repository_bump_device().

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/platform.h |    6 ------
 1 files changed, 6 deletions(-)

--- a/arch/powerpc/platforms/ps3/platform.h
+++ b/arch/powerpc/platforms/ps3/platform.h
@@ -144,12 +144,6 @@ struct ps3_repository_device {
 	u64 dev_id;
 };
 
-static inline struct ps3_repository_device *ps3_repository_bump_device(
-	struct ps3_repository_device *repo)
-{
-	repo->dev_index++;
-	return repo;
-}
 int ps3_repository_find_device(struct ps3_repository_device *repo);
 int ps3_repository_find_device_by_id(struct ps3_repository_device *repo,
 				     u64 bus_id, u64 dev_id);

-- 
