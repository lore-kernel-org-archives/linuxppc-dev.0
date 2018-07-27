Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cl351Cz6zF09Y
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2018 09:06:57 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org,
	diana.craciun@nxp.com
Cc: oss@buserror.net,
	leoyang.li@nxp.com,
	bharat.bhushan@nxp.com
Subject: [PATCH v5 8/8] Documentation: Add nospectre_v1 parameter
Date: Sat, 28 Jul 2018 09:06:39 +1000
Message-Id: <20180727230639.25413-9-mpe@ellerman.id.au>
In-Reply-To: <20180727230639.25413-1-mpe@ellerman.id.au>
References: <20180727230639.25413-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Diana Craciun <diana.craciun@nxp.com>

Currently only supported on powerpc.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++++
 1 file changed, 4 insertions(+)

v5: Change log and whitespace.

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index efc7aa7a0670..4167bbea51e1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2687,6 +2687,10 @@
 	nosmt		[KNL,S390] Disable symmetric multithreading (SMT).
 			Equivalent to smt=1.
 
+	nospectre_v1	[PPC] Disable mitigations for Spectre Variant 1 (bounds
+			check bypass). With this option data leaks are possible
+			in the system.
+
 	nospectre_v2	[X86] Disable all mitigations for the Spectre variant 2
 			(indirect branch prediction) vulnerability. System may
 			allow data leaks with this option, which is equivalent
-- 
2.14.1
