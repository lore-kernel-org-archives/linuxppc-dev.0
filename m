Return-Path: <galak@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 39160681F0
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Sep 2005 00:21:14 +1000 (EST)
Date: Thu, 8 Sep 2005 09:20:55 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <Pine.LNX.4.61.0509080920200.4577@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Fix head_4xx.S compile error
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

head_4xx.S wasn't compiling due to a missing #endif

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 170118f5773bf979d0be23673b703f9dd26d63e7
tree 16e609ae6dd17af7236bbed11a875a1a653a7237
parent 4706df3d3c42af802597d82c8b1542c3d52eab23
author Kumar K. Gala <kumar.gala@freescale.com> Thu, 08 Sep 2005 09:18:08 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Thu, 08 Sep 2005 09:18:08 -0500

 arch/ppc/kernel/head_4xx.S |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/kernel/head_4xx.S b/arch/ppc/kernel/head_4xx.S
--- a/arch/ppc/kernel/head_4xx.S
+++ b/arch/ppc/kernel/head_4xx.S
@@ -453,6 +453,7 @@ label:
 #else
 	CRITICAL_EXCEPTION(0x1020, WDTException, UnknownException)
 #endif
+#endif
 
 /* 0x1100 - Data TLB Miss Exception
  * As the name implies, translation is not in the MMU, so search the
