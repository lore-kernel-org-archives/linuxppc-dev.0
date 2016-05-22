Return-Path: <geert@linux-m68k.org>
Received: from newton.telenet-ops.be (newton.telenet-ops.be [195.130.132.45])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rCG5B6DJRzDq7w
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 May 2016 19:06:54 +1000 (AEST)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:14])
 by newton.telenet-ops.be (Postfix) with ESMTP id 3rCG5522MGzMrK3p
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 May 2016 11:06:49 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 25/54] MAINTAINERS: Add file patterns for powerpc device tree
 bindings
Date: Sun, 22 May 2016 11:06:02 +0200
Message-Id: <1463907991-7916-26-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
References: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Submitters of device tree binding documentation may forget to CC
the subsystem maintainer if this is missing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
Please apply this patch directly if you want to be involved in device
tree binding documentation for your subsystem.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf54ff0c9c168e26..899abfeba25eedba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6858,6 +6858,7 @@ L:	linuxppc-dev@lists.ozlabs.org
 Q:	http://patchwork.ozlabs.org/project/linuxppc-dev/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 S:	Supported
+F:	Documentation/devicetree/bindings/powerpc/
 F:	Documentation/powerpc/
 F:	arch/powerpc/
 F:	drivers/char/tpm/tpm_ibmvtpm*
-- 
1.9.1
