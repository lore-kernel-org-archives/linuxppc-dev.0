Return-Path: <fabf@skynet.be>
Received: from mailrelay118.isp.belgacom.be (mailrelay118.isp.belgacom.be
 [195.238.20.145])
 by lists.ozlabs.org (Postfix) with ESMTP id 4AE701A09A2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 06:18:16 +1100 (AEDT)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 04/35 linux-next] tty/hvc_opal: constify of_device_id array
Date: Mon, 16 Mar 2015 20:17:10 +0100
Message-Id: <1426533469-25458-5-git-send-email-fabf@skynet.be>
In-Reply-To: <1426533469-25458-1-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
Cc: Fabian Frederick <fabf@skynet.be>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/tty/hvc/hvc_opal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 071551b..543b234 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -41,7 +41,7 @@
 
 static const char hvc_opal_name[] = "hvc_opal";
 
-static struct of_device_id hvc_opal_match[] = {
+static const struct of_device_id hvc_opal_match[] = {
 	{ .name = "serial", .compatible = "ibm,opal-console-raw" },
 	{ .name = "serial", .compatible = "ibm,opal-console-hvsi" },
 	{ },
-- 
2.1.0
