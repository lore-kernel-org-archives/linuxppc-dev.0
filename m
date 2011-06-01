Return-Path: <ralf@linux-mips.org>
Received: from duck.linux-mips.net (h5.dl5rb.org.uk [81.2.74.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EA6FEB74DF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jun 2011 05:47:42 +1000 (EST)
Message-Id: <20110601180610.684557757@duck.linux-mips.net>
Date: Wed, 01 Jun 2011 19:05:05 +0100
From: ralf@linux-mips.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [patch 09/14] i8253: Alpha,
	PowerPC: Remove unused <asm/8253pit.h> header.
References: <20110601180456.801265664@duck.linux-mips.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	Matt Turner <mattst88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
To: linux-kernel@vger.kernel.org
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org

 arch/alpha/include/asm/8253pit.h   |    3 ---
 arch/powerpc/include/asm/8253pit.h |    3 ---
 2 files changed, 6 deletions(-)

Index: linux-mips/arch/alpha/include/asm/8253pit.h
===================================================================
--- linux-mips.orig/arch/alpha/include/asm/8253pit.h
+++ /dev/null
@@ -1,3 +0,0 @@
-/*
- * 8253/8254 Programmable Interval Timer
- */
Index: linux-mips/arch/powerpc/include/asm/8253pit.h
===================================================================
--- linux-mips.orig/arch/powerpc/include/asm/8253pit.h
+++ /dev/null
@@ -1,3 +0,0 @@
-/*
- * 8253/8254 Programmable Interval Timer
- */
