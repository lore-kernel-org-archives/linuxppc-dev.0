Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3C0E568681
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Nov 2005 06:50:38 +1100 (EST)
Date: Wed, 2 Nov 2005 12:46:28 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051102144628.GF2609@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32 8xx: Fix harmless warning in 8xx_io/commproc.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


diff-tree eea4169e9343e5e464355a442eca5c5cd6f3485e (from 3fff5da0af579a9cfadedca55dff888cde61b954)
Author: Marcelo Tosatti <marcelo@pegasos.cnet>
Date:   Tue Oct 25 17:10:10 2005 -0500

    Fix harmless warning in 8xx_io/commproc.c

diff --git a/include/asm-ppc/commproc.h b/include/asm-ppc/commproc.h
index 5bbb8e2..973e609 100644
--- a/include/asm-ppc/commproc.h
+++ b/include/asm-ppc/commproc.h
@@ -83,6 +83,8 @@ extern uint m8xx_cpm_hostalloc(uint size
 extern int  m8xx_cpm_hostfree(uint start);
 extern void m8xx_cpm_hostdump(void);
 
+extern void cpm_load_patch(volatile immap_t *immr);
+
 /* Buffer descriptors used by many of the CPM protocols.
 */
 typedef struct cpm_buf_desc {
