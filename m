Return-Path: <bunk@kernel.org>
Received: from mailhub.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with ESMTP id 62958DDEC4
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 03:24:31 +1000 (EST)
Date: Tue, 21 Aug 2007 18:57:58 +0200
From: Adrian Bunk <bunk@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>
Subject: [2.6 patch] ppc .gitignore update
Message-ID: <20070821165758.GB30705@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

arch/ppc/.gitignore shouldn't exclude arch/ppc/boot/include

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
--- a/arch/ppc/.gitignore
+++ b/arch/ppc/.gitignore
@@ -1 +1 @@
-include
+/include
