Return-Path: <ltanure@gmail.com>
Received: from mail-qg0-x22b.google.com (mail-qg0-x22b.google.com
 [IPv6:2607:f8b0:400d:c04::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 190FF1A0094
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 23:24:22 +1000 (EST)
Received: by mail-qg0-f43.google.com with SMTP id a108so3247863qge.30
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 06:24:19 -0700 (PDT)
Sender: Lucas Tanure <ltanure@gmail.com>
Date: Thu, 24 Jul 2014 10:24:06 -0300
From: Lucas Tanure <tanure@linux.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, trivial@kernel.org,
 kernelnewbies <kernelnewbies@kernelnewbies.org>
Subject: [PATCH] powerpc: fix wrong defintion in boot/io.h
Message-ID: <20140724132406.GA2159@ttmp-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix wrong __IO_H definition in boot/io.h

Reported-by: Fernando Silveira <fsilveira@gmail.com>
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 arch/powerpc/boot/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/io.h b/arch/powerpc/boot/io.h
index 7c09f48..394da55 100644
--- a/arch/powerpc/boot/io.h
+++ b/arch/powerpc/boot/io.h
@@ -1,5 +1,5 @@
 #ifndef _IO_H
-#define __IO_H
+#define _IO_H
 
 #include "types.h"
 
-- 
2.0.0
