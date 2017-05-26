Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYzsB3DhMzDqT2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 18:32:30 +1000 (AEST)
Date: Fri, 26 May 2017 18:32:29 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: use uapi/asm-generic/sockios.h
Message-ID: <20170526183229.193ef0eb@canb.auug.org.au>
In-Reply-To: <20170526161946.7bf423c4@canb.auug.org.au>
References: <20170526161946.7bf423c4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

The arch version is identical except for comments and white space.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/include/uapi/asm/Kbuild    |  1 +
 arch/powerpc/include/uapi/asm/sockios.h | 20 --------------------
 2 files changed, 1 insertion(+), 20 deletions(-)
 delete mode 100644 arch/powerpc/include/uapi/asm/sockios.h

This follows on from my previous "powerpc: use the asm-genric versions
of some uapi includes".

diff --git a/arch/powerpc/include/uapi/asm/Kbuild b/arch/powerpc/include/uapi/asm/Kbuild
index 9aba4af4122e..0d960ef78a9a 100644
--- a/arch/powerpc/include/uapi/asm/Kbuild
+++ b/arch/powerpc/include/uapi/asm/Kbuild
@@ -4,4 +4,5 @@ include include/uapi/asm-generic/Kbuild.asm
 generic-y += param.h
 generic-y += poll.h
 generic-y += resource.h
+generic-y += sockios.h
 generic-y += statfs.h
diff --git a/arch/powerpc/include/uapi/asm/sockios.h b/arch/powerpc/include/uapi/asm/sockios.h
deleted file mode 100644
index 55cef7675a31..000000000000
--- a/arch/powerpc/include/uapi/asm/sockios.h
+++ /dev/null
@@ -1,20 +0,0 @@
-#ifndef _ASM_POWERPC_SOCKIOS_H
-#define _ASM_POWERPC_SOCKIOS_H
-
-/*
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-/* Socket-level I/O control calls. */
-#define FIOSETOWN 	0x8901
-#define SIOCSPGRP	0x8902
-#define FIOGETOWN	0x8903
-#define SIOCGPGRP	0x8904
-#define SIOCATMARK	0x8905
-#define SIOCGSTAMP	0x8906		/* Get stamp (timeval) */
-#define SIOCGSTAMPNS	0x8907		/* Get stamp (timespec) */
-
-#endif	/* _ASM_POWERPC_SOCKIOS_H */
-- 
2.11.0

-- 
Cheers,
Stephen Rothwell
