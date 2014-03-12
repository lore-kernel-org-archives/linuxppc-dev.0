Return-Path: <jwboyer@gmail.com>
Received: from mail-ie0-x232.google.com (mail-ie0-x232.google.com
 [IPv6:2607:f8b0:4001:c03::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3C5F02C00B5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Mar 2014 05:21:24 +1100 (EST)
Received: by mail-ie0-f178.google.com with SMTP id lx4so10636056iec.23
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Mar 2014 11:21:20 -0700 (PDT)
Date: Wed, 12 Mar 2014 14:21:04 -0400
From: Josh Boyer <jwboyer@gmail.com>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Update ppc4xx maintainer
Message-ID: <20140312182104.GA32023@zod>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alistair Popple has volunteered to take over maintainership of the ppc4xx
stuff upstream.  Switch the MAINTAINERS entry over to him.

Signed-off-by: Josh Boyer <jwboyer@gmail.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ecfde1..6d220c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5245,11 +5245,10 @@ F:	arch/powerpc/platforms/512x/
 F:	arch/powerpc/platforms/52xx/
 
 LINUX FOR POWERPC EMBEDDED PPC4XX
-M:	Josh Boyer <jwboyer@gmail.com>
+M:  Alistair Popple <alistair@popple.id.au>
 M:	Matt Porter <mporter@kernel.crashing.org>
 W:	http://www.penguinppc.org/
 L:	linuxppc-dev@lists.ozlabs.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git
 S:	Maintained
 F:	arch/powerpc/platforms/40x/
 F:	arch/powerpc/platforms/44x/
-- 
1.8.5.3
