Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EEE67DE2EC
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 08:18:43 +1000 (EST)
Message-ID: <46730D5F.4040701@am.sony.com>
Date: Fri, 15 Jun 2007 15:06:23 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 24/33] powerpc: Correct __secondary_hold comment
References: <20070615204749.629571012@am.sony.com>>
In-Reply-To: <20070615204749.629571012@am.sony.com>>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove references to pSeries and OpenFirmware in the __secondary_hold
usage comment.  __secondary_hold is a generic routine and can be used
by other platforms.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/kernel/head_64.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -103,8 +103,8 @@ __secondary_hold_acknowledge:
 
 	. = 0x60
 /*
- * The following code is used on pSeries to hold secondary processors
- * in a spin loop after they have been freed from OpenFirmware, but
+ * The following code is used to hold secondary processors
+ * in a spin loop after they have entered the kernel, but
  * before the bulk of the kernel has been relocated.  This code
  * is relocated to physical address 0x60 before prom_init is run.
  * All of it must fit below the first exception vector at 0x100.

-- 
