Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id 7421ADE0EE
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Sep 2008 17:50:32 +1000 (EST)
Date: Mon, 15 Sep 2008 09:50:18 +0200
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: linux-ppc <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: ignore generated vmlinux.lds
Message-ID: <20080915095018.1b16cd00@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


  Add a .gitignore in arch/powerpc/kernel to ignore the generated
vmlinux.lds.

Signed-off-by: Sebastien Dugue <sebastien.dugue@bull.net>
---
 arch/powerpc/kernel/.gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/kernel/.gitignore

diff --git a/arch/powerpc/kernel/.gitignore b/arch/powerpc/kernel/.gitignore
new file mode 100644
index 0000000..c5f676c
--- /dev/null
+++ b/arch/powerpc/kernel/.gitignore
@@ -0,0 +1 @@
+vmlinux.lds
-- 
1.6.0.1.308.gede4c
