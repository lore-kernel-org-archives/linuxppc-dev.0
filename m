Return-Path: <mathieu.desnoyers@polymtl.ca>
Received: from smtp.polymtl.ca (smtp.polymtl.ca [132.207.4.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.polymtl.ca", Issuer "Ca_Cert_Smtp_Poly" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0D2FBDDF35
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 02:56:47 +1000 (EST)
Message-Id: <20070703164629.363240511@polymtl.ca>
References: <20070703164534.492133618@polymtl.ca>
Date: Tue, 03 Jul 2007 12:45:36 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [patch 2/3] Add missing DATA_DATA in powerpc
Cc: paulus@samba.org, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: paulus@samba.org
CC: linuxppc-dev@ozlabs.org
--
 arch/powerpc/kernel/vmlinux.lds.S |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6-lttng/arch/powerpc/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6-lttng.orig/arch/powerpc/kernel/vmlinux.lds.S	2007-06-16 22:17:53.000000000 -0400
+++ linux-2.6-lttng/arch/powerpc/kernel/vmlinux.lds.S	2007-06-16 22:18:32.000000000 -0400
@@ -173,7 +173,9 @@
 	}
 #else
 	.data : {
-		*(.data .data.rel* .toc1)
+		DATA_DATA
+		*(.data.rel*)
+		*(.toc1)
 		*(.branch_lt)
 	}
 

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
