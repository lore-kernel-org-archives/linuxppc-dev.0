Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 227CFDE1DC
	for <linuxppc-dev@ozlabs.org>; Fri, 30 May 2008 22:51:35 +1000 (EST)
Date: Fri, 30 May 2008 16:51:33 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [OF] of_gpio: should use new <linux/gpio.h> header
Message-ID: <20080530125133.GA20303@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Wolfgang Grandegger <wg@grandegger.com>

Since commit 7560fa60fcdcdb0da662f6a9fad9064b554ef46c (gpio: <linux/gpio.h>
and "no GPIO support here" stubs) drivers can use GPIOs if they're available,
but don't require them.

This patch actually enables this feature.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 include/linux/of_gpio.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
index 2ee97e9..67db101 100644
--- a/include/linux/of_gpio.h
+++ b/include/linux/of_gpio.h
@@ -15,7 +15,7 @@
 #define __LINUX_OF_GPIO_H
 
 #include <linux/errno.h>
-#include <asm/gpio.h>
+#include <linux/gpio.h>
 
 #ifdef CONFIG_OF_GPIO
 
-- 
1.5.5.1
