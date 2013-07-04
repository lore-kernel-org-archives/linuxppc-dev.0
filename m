Return-Path: <R65777@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 33B892C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 16:24:20 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <mikey@neuling.org>,
 <benh@kernel.crashing.org>, <linux-kernel@vger.kernel.org>,
 <scottwood@freescale.com>, <agraf@suse.de>
Subject: [PATCH 1/2] powerpc: remove unnecessary line continuations
Date: Thu, 4 Jul 2013 11:45:45 +0530
Message-ID: <1372918546-15075-2-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1372918546-15075-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1372918546-15075-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
 arch/powerpc/kernel/process.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index c517dbe..19b8733 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -325,7 +325,7 @@ static void set_debug_reg_defaults(struct thread_struct *thread)
 	/*
 	 * Force User/Supervisor bits to b11 (user-only MSR[PR]=1)
 	 */
-	thread->dbcr1 = DBCR1_IAC1US | DBCR1_IAC2US |	\
+	thread->dbcr1 = DBCR1_IAC1US | DBCR1_IAC2US |
 			DBCR1_IAC3US | DBCR1_IAC4US;
 	/*
 	 * Force Data Address Compare User/Supervisor bits to be User-only
-- 
1.7.0.4
