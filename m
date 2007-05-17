Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C1C8DDE38
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 23:02:24 +1000 (EST)
Date: Thu, 17 May 2007 07:57:51 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PPC] Remove duplicate export of __div64_32.
Message-ID: <Pine.LNX.4.64.0705170756500.4833@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We now get the export of __div64_32 from lib/div64.c and can drop the one
in ppc_ksysm.c

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---

This is in the for_paulus branch of my powerpc.git, just posting for
completeness.

- k

commit f5e6eb4606a69c8e661cb6f976e206f859bc1b0f
tree b8ae348e1c4fa721fc81d55420b23f5a7fb6a5cf
parent a440da68f5e93544ef5c924792b2a5b556c4a535
author Kumar Gala <galak@kernel.crashing.org> Thu, 17 May 2007 07:52:42 -0500
committer Kumar Gala <galak@kernel.crashing.org> Thu, 17 May 2007 07:52:42 -0500

 arch/ppc/kernel/ppc_ksyms.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
index 4ad4996..e76f076 100644
--- a/arch/ppc/kernel/ppc_ksyms.c
+++ b/arch/ppc/kernel/ppc_ksyms.c
@@ -93,7 +93,6 @@ EXPORT_SYMBOL(strncpy);
 EXPORT_SYMBOL(strcat);
 EXPORT_SYMBOL(strlen);
 EXPORT_SYMBOL(strcmp);
-EXPORT_SYMBOL(__div64_32);

 EXPORT_SYMBOL(csum_partial);
 EXPORT_SYMBOL(csum_partial_copy_generic);
