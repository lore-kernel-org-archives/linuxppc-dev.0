Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 64CAFB7F33
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 11:00:27 +1100 (EST)
Date: Tue, 8 Mar 2011 01:00:23 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 28/28] powerpc: Enable GENERIC_HARDIRQS_NO_DEPRECATED.
Message-ID: <20110308000023.GG16649@mail.wantstofly.org>
References: <cover.1299541392.git.buytenh@wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1299541392.git.buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/powerpc/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 7d69e9b..71ba047 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -134,6 +134,7 @@ config PPC
 	select HAVE_GENERIC_HARDIRQS
 	select HAVE_SPARSE_IRQ
 	select IRQ_PER_CPU
+	select GENERIC_HARDIRQS_NO_DEPRECATED
 
 config EARLY_PRINTK
 	bool
-- 
1.7.4
