Return-Path: <prvs=5540a0381=luisbg@amazon.com>
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com
 [207.171.184.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQq0r4N2MzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 00:30:04 +1100 (AEDT)
From: Luis de Bethencourt <luisbg@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Joe Perches <joe@perches.com>, Paul Mackerras <paulus@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Russell Currey <ruscur@russell.cc>,
 David Gibson <david@gibson.dropbear.id.au>,
 Alistair Popple <alistair@popple.id.au>, Rob Herring <robh@kernel.org>,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Luis de Bethencourt <luisbg@kernel.org>
Subject: [PATCH 2/2] KVM: PPC: Book3S HV: Fix trailing semicolon
Date: Tue, 23 Jan 2018 13:29:35 +0000
Message-Id: <20180123132935.24995-2-luisbg@kernel.org>
In-Reply-To: <20180123132935.24995-1-luisbg@kernel.org>
References: <20180123132935.24995-1-luisbg@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The trailing semicolon is an empty statement that does no operation.
Removing it since it doesn't do anything.

Signed-off-by: Luis de Bethencourt <luisbg@kernel.org>
---
 arch/powerpc/kvm/book3s_xive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index f0f5cd4d2fe7..f9818d7d3381 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -188,7 +188,7 @@ static int xive_provision_queue(struct kvm_vcpu *vcpu, u8 prio)
 	if (!qpage) {
 		pr_err("Failed to allocate queue %d for VCPU %d\n",
 		       prio, xc->server_num);
-		return -ENOMEM;;
+		return -ENOMEM;
 	}
 	memset(qpage, 0, 1 << xive->q_order);
 
-- 
2.15.1
