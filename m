Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjRgC2BJSzDwRV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 16:49:11 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	sjitindarsingh@gmail.com
Cc: benh@kernel.crashing.org, thuth@redhat.com, lvivier@redhat.com,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCHv2 01/11] Documentation: Correct duplicate section number in
 kvm/api.txt
Date: Tue, 20 Dec 2016 16:48:57 +1100
Message-Id: <20161220054907.9204-2-david@gibson.dropbear.id.au>
In-Reply-To: <20161220054907.9204-1-david@gibson.dropbear.id.au>
References: <20161220054907.9204-1-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Both KVM_CREATE_SPAPR_TCE_64 and KVM_REINJECT_CONTROL have section number
4.98 in Documentation/virtual/kvm/api.txt, presumably due to a naive merge.
This corrects the duplication.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 Documentation/virtual/kvm/api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 03145b7..42be7b1 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -3177,7 +3177,7 @@ of IOMMU pages.
 
 The rest of functionality is identical to KVM_CREATE_SPAPR_TCE.
 
-4.98 KVM_REINJECT_CONTROL
+4.99 KVM_REINJECT_CONTROL
 
 Capability: KVM_CAP_REINJECT_CONTROL
 Architectures: x86
-- 
2.9.3
