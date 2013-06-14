Return-Path: <sebastien.bessiere@gmail.com>
Received: from mail-wg0-x22c.google.com (mail-wg0-x22c.google.com
 [IPv6:2a00:1450:400c:c00::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BCEAE2C0040
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 01:57:16 +1000 (EST)
Received: by mail-wg0-f44.google.com with SMTP id m15so656951wgh.23
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 08:57:11 -0700 (PDT)
From: Sebastien Bessiere <sebastien.bessiere@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] trivial: powerpc: fix typo in ioei_interrupt() description
Date: Fri, 14 Jun 2013 17:57:03 +0200
Message-Id: <1371225423-3039-1-git-send-email-sebastien.bessiere@gmail.com>
Cc: Sebastien Bessiere <sebastien.bessiere@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Sebastien Bessiere <sebastien.bessiere@gmail.com>
---
 arch/powerpc/platforms/pseries/io_event_irq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/io_event_irq.c b/arch/powerpc/platforms/pseries/io_event_irq.c
index ef9d9d8..5ea88d1 100644
--- a/arch/powerpc/platforms/pseries/io_event_irq.c
+++ b/arch/powerpc/platforms/pseries/io_event_irq.c
@@ -115,7 +115,7 @@ static struct pseries_io_event * ioei_find_event(struct rtas_error_log *elog)
  *   by scope or event type alone. For example, Torrent ISR route change
  *   event is reported with scope 0x00 (Not Applicatable) rather than
  *   0x3B (Torrent-hub). It is better to let the clients to identify
- *   who owns the the event.
+ *   who owns the event.
  */
 
 static irqreturn_t ioei_interrupt(int irq, void *dev_id)
-- 
1.7.9.5
