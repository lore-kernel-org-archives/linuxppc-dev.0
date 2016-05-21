Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lb0-x244.google.com (mail-lb0-x244.google.com
 [IPv6:2a00:1450:4010:c04::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk6f4bxfzDqVr
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:06:18 +1000 (AEST)
Received: by mail-lb0-x244.google.com with SMTP id mx9so6879618lbb.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:06:18 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0227/1529] Fix typo
Date: Sat, 21 May 2016 14:06:09 +0200
Message-Id: <20160521120609.11793-1-andrea.gelmini@gelma.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/powerpc/kernel/rtas-proc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/rtas-proc.c b/arch/powerpc/kernel/rtas-proc.c
index fb2fb3e..9026661 100644
--- a/arch/powerpc/kernel/rtas-proc.c
+++ b/arch/powerpc/kernel/rtas-proc.c
@@ -527,7 +527,7 @@ static void ppc_rtas_process_sensor(struct seq_file *m,
 		"EPOW power off" };
 	const char * battery_cyclestate[]  = { "None", "In progress", 
 						"Requested" };
-	const char * battery_charging[]    = { "Charging", "Discharching", 
+	const char * battery_charging[]    = { "Charging", "Discharging", 
 						"No current flow" };
 	const char * ibm_drconnector[]     = { "Empty", "Present", "Unusable", 
 						"Exchange" };
@@ -695,10 +695,10 @@ static void check_location(struct seq_file *m, const char *c)
 
 
 /* ****************************************************************** */
-/* 
- * Format: 
+/*
+ * Format:
  * ${LETTER}${NUMBER}[[-/]${LETTER}${NUMBER} [ ... ] ]
- * the '.' may be an abbrevation
+ * the '.' may be an abbreviation
  */
 static void check_location_string(struct seq_file *m, const char *c)
 {
-- 
2.8.2.534.g1f66975
