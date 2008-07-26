Return-Path: <weiyi.huang@gmail.com>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.185])
	by ozlabs.org (Postfix) with ESMTP id 33081DE032
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 21:37:58 +1000 (EST)
Received: by ti-out-0910.google.com with SMTP id w7so2006638tib.13
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 04:37:56 -0700 (PDT)
Date: Sat, 26 Jul 2008 19:37:54 +0800
From: Huang Weiyi <weiyi.huang@gmail.com>
To: leoli@freescale.com
Subject: ucc_geth_ethtool.c: removed duplicated include
Message-Id: <20080726115456.F237.WEIYI.HUANG@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Removed duplicated include <asm/uaccess.h> in 
drivers/net/ucc_geth_ethtool.c.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

--- a/drivers/net/ucc_geth_ethtool.c    2008-05-10 08:41:10.000000000 +0800
+++ b/drivers/net/ucc_geth_ethtool.c    2008-05-10 08:41:42.000000000 +0800
@@ -37,7 +37,6 @@
 #include <asm/irq.h>
 #include <asm/uaccess.h>
 #include <asm/types.h>
-#include <asm/uaccess.h>

 #include "ucc_geth.h"
 #include "ucc_geth_mii.h"
