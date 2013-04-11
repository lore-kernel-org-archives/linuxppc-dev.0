Return-Path: <B02008@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2148D2C011E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 20:08:27 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 7/8 v3] KVM: PPC: e500mc: Enable e6500 cores
Date: Thu, 11 Apr 2013 13:03:13 +0300
Message-ID: <1365674594-17410-8-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1365674594-17410-1-git-send-email-mihai.caraman@freescale.com>
References: <1365674594-17410-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Extend processor compatibility names to e6500 cores.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
Reviewed-by: Alexander Graf <agraf@suse.de>
---
v3:
 - No change

 arch/powerpc/kvm/e500mc.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
index ab073a8..c3bdc0a 100644
--- a/arch/powerpc/kvm/e500mc.c
+++ b/arch/powerpc/kvm/e500mc.c
@@ -172,6 +172,8 @@ int kvmppc_core_check_processor_compat(void)
 		r = 0;
 	else if (strcmp(cur_cpu_spec->cpu_name, "e5500") == 0)
 		r = 0;
+	else if (strcmp(cur_cpu_spec->cpu_name, "e6500") == 0)
+		r = 0;
 	else
 		r = -ENOTSUPP;
 
-- 
1.7.4.1
