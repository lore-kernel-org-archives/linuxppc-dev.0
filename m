Return-Path: <PeterHuewe@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 99D44B7DF7
	for <linuxppc-dev@ozlabs.org>; Fri, 14 May 2010 21:26:55 +1000 (EST)
From: Peter =?iso-8859-1?q?H=FCwe?= <PeterHuewe@gmx.de>
To: linux-next@vger.kernel.org
Subject: Re: [PATCH] media/IR: Add missing include file to rc-map.c
Date: Fri, 14 May 2010 13:26:51 +0200
References: <201005051720.22617.PeterHuewe@gmx.de>
	<201005112042.14889.PeterHuewe@gmx.de>
	<20100514060240.GD12002@linux-sh.org>
In-Reply-To: <20100514060240.GD12002@linux-sh.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201005141326.52099.PeterHuewe@gmx.de>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org, David H?rdeman <david@hardeman.nu>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	linuxppc-dev@ozlabs.org, linux-m68k@lists.linux-m68k.org,
	Paul Mundt <lethal@linux-sh.org>, linux-media@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Peter Huewe <peterhuewe@gmx.de>

This patch adds a missing include linux/delay.h to prevent
build failures[1-5]

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
Forwarded to linux-next mailing list - 
breakage still exists in linux-next of 20100514 - please apply

KernelVersion: linux-next-20100505

References:
[1] http://kisskb.ellerman.id.au/kisskb/buildresult/2571452/
[2] http://kisskb.ellerman.id.au/kisskb/buildresult/2571188/
[3] http://kisskb.ellerman.id.au/kisskb/buildresult/2571479/
[4] http://kisskb.ellerman.id.au/kisskb/buildresult/2571429/
[5] http://kisskb.ellerman.id.au/kisskb/buildresult/2571432/

drivers/media/IR/rc-map.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/media/IR/rc-map.c b/drivers/media/IR/rc-map.c
index caf6a27..46a8f15 100644
--- a/drivers/media/IR/rc-map.c
+++ b/drivers/media/IR/rc-map.c
@@ -14,6 +14,7 @@
 
 #include <media/ir-core.h>
 #include <linux/spinlock.h>
+#include <linux/delay.h>
 
 /* Used to handle IR raw handler extensions */
 static LIST_HEAD(rc_map_list);
-- 
1.6.4.4
