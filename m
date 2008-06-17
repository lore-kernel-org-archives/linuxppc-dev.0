Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BA278DDE9F
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 03:00:03 +1000 (EST)
Date: Tue, 17 Jun 2008 11:59:59 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH] powerpc: clrsetbits_le16: fix copy-and-paste error
Message-ID: <20080617165959.GA3324@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This was pointed out by Detlev Zundel when this code was being
added to U-boot.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
Note that nothing currently uses the le16 version, so it's not
an urgent bugfix.

 include/asm-powerpc/io.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-powerpc/io.h b/include/asm-powerpc/io.h
index 6db422d..8b62782 100644
--- a/include/asm-powerpc/io.h
+++ b/include/asm-powerpc/io.h
@@ -772,7 +772,7 @@ static inline void * bus_to_virt(unsigned long address)
 #define clrsetbits_le32(addr, clear, set) clrsetbits(le32, addr, clear, set)
 
 #define clrsetbits_be16(addr, clear, set) clrsetbits(be16, addr, clear, set)
-#define clrsetbits_le16(addr, clear, set) clrsetbits(le32, addr, clear, set)
+#define clrsetbits_le16(addr, clear, set) clrsetbits(le16, addr, clear, set)
 
 #define clrsetbits_8(addr, clear, set) clrsetbits(8, addr, clear, set)
 
-- 
1.5.5.4
