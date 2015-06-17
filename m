Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6F2361A09C0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2015 10:35:46 +1000 (AEST)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] powerpc/include: Add opal-prd to installed uapi headers
Message-Id: <1434501339.929925.993851254314.1.gpush@pablo>
To: linuxppc-dev@lists.ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 17 Jun 2015 08:35:39 +0800
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We'll want to build the opal-prd daemon with the prd headers, so include
this in the uapi headers list.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/include/uapi/asm/Kbuild |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/uapi/asm/Kbuild b/arch/powerpc/include/uapi/asm/Kbuild
index 79c4068..f44a0278 100644
--- a/arch/powerpc/include/uapi/asm/Kbuild
+++ b/arch/powerpc/include/uapi/asm/Kbuild
@@ -18,6 +18,7 @@ header-y += kvm_para.h
 header-y += mman.h
 header-y += msgbuf.h
 header-y += nvram.h
+header-y += opal-prd.h
 header-y += param.h
 header-y += perf_event.h
 header-y += poll.h
