Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 15CF1DDEF0
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 12:16:51 +1000 (EST)
Date: Sat, 2 May 2009 06:16:49 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/6] powerpc/85xx: Fix mpc8569emds' crypto node to include
	SNOW unit
Message-ID: <20090502021649.GB18281@oksana.dev.rtsoft.ru>
References: <20090502021611.GA17570@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090502021611.GA17570@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Haiying Wang <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

fsl,exec-units-mask should be 0xbfe to include SNOW unit in
MPC8569E's security engine.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8569mds.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8569mds.dts b/arch/powerpc/boot/dts/mpc8569mds.dts
index e16a5d4..bcf8042 100644
--- a/arch/powerpc/boot/dts/mpc8569mds.dts
+++ b/arch/powerpc/boot/dts/mpc8569mds.dts
@@ -222,7 +222,7 @@
 			interrupt-parent = <&mpic>;
 			fsl,num-channels = <4>;
 			fsl,channel-fifo-len = <24>;
-			fsl,exec-units-mask = <0x9fe>;
+			fsl,exec-units-mask = <0xbfe>;
 			fsl,descriptor-types-mask = <0x3ab0ebf>;
 		};
 
-- 
1.6.2.2
