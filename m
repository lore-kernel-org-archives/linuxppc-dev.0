Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <7601901ad2a96aed4d9d8603d438e1faee2bba75.1202949456.git.michael@ellerman.id.au>
In-Reply-To: <3bcbba96837cfcdeb873d26d51241c9659e77930.1202949456.git.michael@ellerman.id.au>
References: <3bcbba96837cfcdeb873d26d51241c9659e77930.1202949456.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/2] Add include of linux/of.h to os-area.c
Date: Thu, 14 Feb 2008 11:37:50 +1100 (EST)
Cc: "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

os-area.c requires routines in linux/of.h, so should include it.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/ps3/os-area.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/os-area.c b/arch/powerpc/platforms/ps3/os-area.c
index b9ea09d..70d8052 100644
--- a/arch/powerpc/platforms/ps3/os-area.c
+++ b/arch/powerpc/platforms/ps3/os-area.c
@@ -24,6 +24,7 @@
 #include <linux/fs.h>
 #include <linux/syscalls.h>
 #include <linux/ctype.h>
+#include <linux/of.h>
 
 #include <asm/lmb.h>
 
-- 
1.5.2.rc1.1884.g59b20
