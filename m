Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B63C0B7BF4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 Nov 2009 17:18:55 +1100 (EST)
Subject: [PATCH] powerpc/kvm: Fix non-modular build
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: kvmppc <kvm-ppc@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 05 Nov 2009 17:18:48 +1100
Message-ID: <1257401928.13611.105.camel@pasglop>
Mime-Version: 1.0
Cc: Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kvm/timing.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kvm/timing.c b/arch/powerpc/kvm/timing.c
index 2aa371e..7037855 100644
--- a/arch/powerpc/kvm/timing.c
+++ b/arch/powerpc/kvm/timing.c
@@ -23,6 +23,7 @@
 #include <linux/seq_file.h>
 #include <linux/debugfs.h>
 #include <linux/uaccess.h>
+#include <linux/module.h>
 
 #include <asm/time.h>
 #include <asm-generic/div64.h>
