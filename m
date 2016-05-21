Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lb0-x241.google.com (mail-lb0-x241.google.com
 [IPv6:2a00:1450:4010:c04::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk9D48GSzDqVy
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:08:32 +1000 (AEST)
Received: by mail-lb0-x241.google.com with SMTP id mx9so6881389lbb.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:08:32 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0245/1529] Fix typo
Date: Sat, 21 May 2016 14:08:25 +0200
Message-Id: <20160521120825.12785-1-andrea.gelmini@gelma.net>
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
 arch/powerpc/platforms/pseries/io_event_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/io_event_irq.c b/arch/powerpc/platforms/pseries/io_event_irq.c
index 0240c4f..f053bda 100644
--- a/arch/powerpc/platforms/pseries/io_event_irq.c
+++ b/arch/powerpc/platforms/pseries/io_event_irq.c
@@ -113,7 +113,7 @@ static struct pseries_io_event * ioei_find_event(struct rtas_error_log *elog)
  * - The owner of an event is determined by combinations of scope,
  *   event type, and sub-type. There is no easy way to pre-sort clients
  *   by scope or event type alone. For example, Torrent ISR route change
- *   event is reported with scope 0x00 (Not Applicatable) rather than
+ *   event is reported with scope 0x00 (Not Applicable) rather than
  *   0x3B (Torrent-hub). It is better to let the clients to identify
  *   who owns the event.
  */
-- 
2.8.2.534.g1f66975
