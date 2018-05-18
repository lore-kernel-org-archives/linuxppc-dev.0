Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by lists.ozlabs.org (Postfix) with ESMTP id 40nNGV0qtGzF29J
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 19:31:30 +1000 (AEST)
From: Colin King <colin.king@canonical.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: fix spelling mistake: "Discharching" -> "Discharging"
Date: Fri, 18 May 2018 10:31:17 +0100
Message-Id: <20180518093117.25668-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in battery_charging array

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/powerpc/kernel/rtas-proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/rtas-proc.c b/arch/powerpc/kernel/rtas-proc.c
index d49063d0baa4..ed0ed0c9b7b3 100644
--- a/arch/powerpc/kernel/rtas-proc.c
+++ b/arch/powerpc/kernel/rtas-proc.c
@@ -504,7 +504,7 @@ static void ppc_rtas_process_sensor(struct seq_file *m,
 		"EPOW power off" };
 	const char * battery_cyclestate[]  = { "None", "In progress", 
 						"Requested" };
-	const char * battery_charging[]    = { "Charging", "Discharching", 
+	const char * battery_charging[]    = { "Charging", "Discharging",
 						"No current flow" };
 	const char * ibm_drconnector[]     = { "Empty", "Present", "Unusable", 
 						"Exchange" };
-- 
2.17.0
