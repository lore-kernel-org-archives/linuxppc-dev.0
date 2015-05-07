Return-Path: <ddstreet@gmail.com>
Received: from mail-ig0-x22a.google.com (mail-ig0-x22a.google.com
 [IPv6:2607:f8b0:4001:c05::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DFEDA1A0E2E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 03:49:53 +1000 (AEST)
Received: by igbyr2 with SMTP id yr2so513195igb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2015 10:49:52 -0700 (PDT)
Sender: Dan Streetman <ddstreet@gmail.com>
From: Dan Streetman <ddstreet@ieee.org>
To: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 01/10] powerpc: export of_get_ibm_chip_id function
Date: Thu,  7 May 2015 13:49:12 -0400
Message-Id: <1431020961-22285-2-git-send-email-ddstreet@ieee.org>
In-Reply-To: <1431020961-22285-1-git-send-email-ddstreet@ieee.org>
References: <1431020961-22285-1-git-send-email-ddstreet@ieee.org>
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
index 308c5e1..ea2cea7 100644
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
