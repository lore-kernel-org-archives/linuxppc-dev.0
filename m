Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 37B20DDDF4
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 09:15:31 +1000 (EST)
Message-Id: <200707172309.l6HN9VWt012374@imap1.linux-foundation.org>
Subject: - add-missing-data_data-in-powerpc.patch removed from -mm tree
To: mathieu.desnoyers@polymtl.ca, linuxppc-dev@ozlabs.org, paulus@samba.org,
	mm-commits@vger.kernel.org
From: akpm@linux-foundation.org
Date: Tue, 17 Jul 2007 16:09:31 -0700
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The patch titled
     powerpc: add missing DATA_DATA
has been removed from the -mm tree.  Its filename was
     add-missing-data_data-in-powerpc.patch

This patch was dropped because it was merged into mainline or a subsystem tree

------------------------------------------------------
Subject: powerpc: add missing DATA_DATA
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: <paulus@samba.org>
Cc: <linuxppc-dev@ozlabs.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/kernel/vmlinux.lds.S |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -puN arch/powerpc/kernel/vmlinux.lds.S~add-missing-data_data-in-powerpc arch/powerpc/kernel/vmlinux.lds.S
--- a/arch/powerpc/kernel/vmlinux.lds.S~add-missing-data_data-in-powerpc
+++ a/arch/powerpc/kernel/vmlinux.lds.S
@@ -174,7 +174,9 @@ SECTIONS
 	}
 #else
 	.data : {
-		*(.data .data.rel* .toc1)
+		DATA_DATA
+		*(.data.rel*)
+		*(.toc1)
 		*(.branch_lt)
 	}
 
_

Patches currently in -mm which might be from mathieu.desnoyers@polymtl.ca are

origin.patch
git-kbuild.patch
