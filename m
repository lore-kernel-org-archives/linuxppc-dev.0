Return-Path: <R65777@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C43E92C016A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 15:34:25 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>, <agraf@suse.de>,
 <scottwood@freescale.com>, <tiejun.chen@windriver.com>,
 <benh@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <mikey@neuling.org>
Subject: [PATCH 1/6 v5] powerpc: remove unnecessary line continuations
Date: Wed, 26 Jun 2013 11:12:21 +0530
Message-ID: <1372225346-5029-2-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1372225346-5029-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1372225346-5029-1-git-send-email-Bharat.Bhushan@freescale.com>
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
index ceb4e7b..639a8de 100644
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
