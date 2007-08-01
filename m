Return-Path: <bunk@stusta.de>
Received: from mailhub.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with ESMTP id 66B9FDDE1E
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 23:31:18 +1000 (EST)
Date: Wed, 1 Aug 2007 15:30:56 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Rutger Nijlunsing <rutger@nospam.com>,
	Paul Mackerras <paulus@samba.org>
Subject: [2.6 patch] ppc .gitignore update
Message-ID: <20070801133056.GP3972@stusta.de>
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

arch/ppc/.gitignore shouldn't exclude arch/ppc/boot/include

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---
--- /dev/null	2006-09-19 00:45:31.000000000 +0200
+++ linux-2.6.23-rc1-mm2/arch/ppc/boot/.gitignore	2007-08-01 15:18:33.000000000 +0200
@@ -0,0 +1 @@
+!include
