Return-Path: <av1474@comtv.ru>
Received: from akado.ru (fe01x03-cgp.akado.ru [77.232.31.164])
 by lists.ozlabs.org (Postfix) with ESMTP id 797DB1A0026
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Sep 2014 05:56:03 +1000 (EST)
From: av1474@comtv.ru
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: powerpc: Avoid bashisms in prom_init_check.sh
In-Reply-To: <1410510342.17540.10.camel@concordia> (Michael Ellerman's message
 of "Fri, 12 Sep 2014 18:25:42 +1000")
Date: Fri, 12 Sep 2014 22:55:38 +0400
Message-ID: <87r3zgd5xx.fsf_-_@comtv.ru>
References: <87zjfkvyha.fsf@comtv.ru> <1410510342.17540.10.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From 300a98f895dc7e2167cf379408322a9607907761 Mon Sep 17 00:00:00 2001
From: malc <av1474 at comtv.ru>
Date: Mon, 4 Aug 2014 23:28:05 +0400
Subject: [PATCH] powerpc: Avoid bashisms in prom_init_check.sh

Signed-off-by: Vassili Karpov <av1474@comtv.ru>
---
 arch/powerpc/kernel/prom_init_check.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
index fe8e54b..413f792 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -50,22 +50,22 @@ do
 	done
 
 	# ignore register save/restore funcitons
-	if [ "${UNDEF:0:9}" = "_restgpr_" ]; then
+	if [ "$(printf %.9s $UNDEF)" = "_restgpr_" ]; then
 		OK=1
 	fi
-	if [ "${UNDEF:0:10}" = "_restgpr0_" ]; then
+	if [ "$(printf %.10s $UNDEF)" = "_restgpr0_" ]; then
 		OK=1
 	fi
-	if [ "${UNDEF:0:11}" = "_rest32gpr_" ]; then
+	if [ "$(printf %.11s $UNDEF)" = "_rest32gpr_" ]; then
 		OK=1
 	fi
-	if [ "${UNDEF:0:9}" = "_savegpr_" ]; then
+	if [ "$(printf %.9s $UNDEF)" = "_savegpr_" ]; then
 		OK=1
 	fi
-	if [ "${UNDEF:0:10}" = "_savegpr0_" ]; then
+	if [ "$(printf %.10s $UNDEF)" = "_savegpr0_" ]; then
 		OK=1
 	fi
-	if [ "${UNDEF:0:11}" = "_save32gpr_" ]; then
+	if [ "$(printf %.11s $UNDEF)" = "_save32gpr_" ]; then
 		OK=1
 	fi
 
-- 
2.0.0.GIT

> On Mon, 2014-08-04 at 23:36 +0400, av1474@comtv.ru wrote:
>> From 300a98f895dc7e2167cf379408322a9607907761 Mon Sep 17 00:00:00 2001
>> From: malc <av1474@comtv.ru>
>> Date: Mon, 4 Aug 2014 23:28:05 +0400
>> Subject: [PATCH] Avoid bashisms
>
> Hi malc,
>
> If you want us to take your patch, please resend with:
>   - a better subject, eg:
>     powerpc: Avoid bashisms in prom_init_check.sh
>   - a Signed-off-by line.
>
> cheers

Thanks for suggestions,

-- 
mailto:av1474@comtv.ru
