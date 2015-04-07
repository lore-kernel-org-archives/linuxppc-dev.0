Return-Path: <ddstreet@gmail.com>
Received: from mail-ig0-x233.google.com (mail-ig0-x233.google.com
 [IPv6:2607:f8b0:4001:c05::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F2D11A08FC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 03:35:07 +1000 (AEST)
Received: by igblo3 with SMTP id lo3so18759511igb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2015 10:35:05 -0700 (PDT)
Sender: Dan Streetman <ddstreet@gmail.com>
From: Dan Streetman <ddstreet@ieee.org>
To: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 01/11] powerpc: export of_get_ibm_chip_id function
Date: Tue,  7 Apr 2015 13:34:20 -0400
Message-Id: <1428428070-17803-2-git-send-email-ddstreet@ieee.org>
In-Reply-To: <1428428070-17803-1-git-send-email-ddstreet@ieee.org>
References: <1428428070-17803-1-git-send-email-ddstreet@ieee.org>
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
 Robert Jennings <rob@pochix.net>, linux-crypto@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Seth Jennings <sjennings@variantweb.net>,
 Dan Streetman <ddstreet@ieee.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Export the of_get_ibm_chip_id() function.  This will be used by the
PowerNV NX-842 driver.

Signed-off-by: Dan Streetman <ddstreet@ieee.org>
---
 arch/powerpc/kernel/prom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index b8e15c6..f9fb9a2 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -800,6 +800,7 @@ int of_get_ibm_chip_id(struct device_node *np)
 	}
 	return -1;
 }
+EXPORT_SYMBOL(of_get_ibm_chip_id);
 
 /**
  * cpu_to_chip_id - Return the cpus chip-id
-- 
2.1.0
