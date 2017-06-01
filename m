Return-Path: <mopsfelder@gmail.com>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com
 [IPv6:2607:f8b0:400d:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdsdr23JpzDqFS
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 02:06:08 +1000 (AEST)
Received: by mail-qk0-x244.google.com with SMTP id y201so1872946qka.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Jun 2017 09:06:08 -0700 (PDT)
From: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Murilo Opsfelder Araujo <mopsfelder@gmail.com>
Subject: [PATCH] Update MAINTAINERS
Date: Thu,  1 Jun 2017 13:05:41 -0300
Message-Id: <20170601160541.9794-1-mopsfelder@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

drivers/watchdog/wdrtas.c is of insterest of linuxppc maintainers.

Signed-off-by: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9609ca6..3f05927 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7670,6 +7670,7 @@ F:	drivers/pci/hotplug/rpa*
 F:	drivers/rtc/rtc-opal.c
 F:	drivers/scsi/ibmvscsi/
 F:	drivers/tty/hvc/hvc_opal.c
+F:	drivers/watchdog/wdrtas.c
 F:	tools/testing/selftests/powerpc
 N:	/pmac
 N:	powermac
-- 
2.9.4
