Return-Path: <robherring2@gmail.com>
Received: from mail-ot0-f194.google.com (mail-ot0-f194.google.com
 [74.125.82.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40X9CB48cjzF25Q
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Apr 2018 07:27:50 +1000 (AEST)
Received: by mail-ot0-f194.google.com with SMTP id j27-v6so30941597ota.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 14:27:50 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/4] dt-bindings: powerpc/4xx: move 4xx NDFC and EMAC bindings
 to subsystem directories
Date: Thu, 26 Apr 2018 16:27:43 -0500
Message-Id: <20180426212744.28688-3-robh@kernel.org>
In-Reply-To: <20180426212744.28688-1-robh@kernel.org>
References: <20180426212744.28688-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bindings are supposed to be organized by device class/function. Move a
couple of powerpc 4xx bindings to the correct binding directory.

Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/{powerpc/4xx/ndfc.txt => mtd/ibm,ndfc.txt}        | 0
 .../devicetree/bindings/{powerpc/4xx/emac.txt => net/ibm,emac.txt}        | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{powerpc/4xx/ndfc.txt => mtd/ibm,ndfc.txt} (100%)
 rename Documentation/devicetree/bindings/{powerpc/4xx/emac.txt => net/ibm,emac.txt} (100%)

diff --git a/Documentation/devicetree/bindings/powerpc/4xx/ndfc.txt b/Documentation/devicetree/bindings/mtd/ibm,ndfc.txt
similarity index 100%
rename from Documentation/devicetree/bindings/powerpc/4xx/ndfc.txt
rename to Documentation/devicetree/bindings/mtd/ibm,ndfc.txt
diff --git a/Documentation/devicetree/bindings/powerpc/4xx/emac.txt b/Documentation/devicetree/bindings/net/ibm,emac.txt
similarity index 100%
rename from Documentation/devicetree/bindings/powerpc/4xx/emac.txt
rename to Documentation/devicetree/bindings/net/ibm,emac.txt
-- 
2.14.1
