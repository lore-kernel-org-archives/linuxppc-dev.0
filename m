Return-Path: <anton@samba.org>
Date: Mon, 9 May 2011 09:18:27 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc/pseries: Enable Emulex and Qlogic 10Gbit cards
Message-ID: <20110509091827.552686c9@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Enable the Qlogic and Emulex 10Gbit adapters.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-powerpc/arch/powerpc/configs/pseries_defconfig
===================================================================
--- linux-powerpc.orig/arch/powerpc/configs/pseries_defconfig	2011-05-09 09:14:34.302937721 +1000
+++ linux-powerpc/arch/powerpc/configs/pseries_defconfig	2011-05-09 09:14:40.773045437 +1000
@@ -197,6 +197,8 @@ CONFIG_S2IO=m
 CONFIG_MYRI10GE=m
 CONFIG_NETXEN_NIC=m
 CONFIG_MLX4_EN=m
+CONFIG_QLGE=m
+CONFIG_BE2NET=m
 CONFIG_PPP=m
 CONFIG_PPP_ASYNC=m
 CONFIG_PPP_SYNC_TTY=m
