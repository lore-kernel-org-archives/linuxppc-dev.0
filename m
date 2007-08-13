Return-Path: <joe@perches.com>
Received: from perches.com (DSL022.labridge.com [206.117.136.22])
	by ozlabs.org (Postfix) with ESMTP id 8B746DDE09
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 16:31:49 +1000 (EST)
Date: Sun, 12 Aug 2007 23:22:44 -0700
From: joe@perches.com
To: torvalds@linux-foundation.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, johannes@sipsolutions.net,
	akpm@linux-foundation.org
Subject: [PATCH] [43/2many] MAINTAINERS - AOA (Apple Onboard Audio) ALSA DRIVER
Message-ID: <46bff8b4.nGsvrO+zx5IWj+A6%joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index e2e88f3..016f342 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -420,6 +420,7 @@ M:	johannes@sipsolutions.net
 L:	linuxppc-dev@ozlabs.org
 L:	alsa-devel@alsa-project.org (subscribers-only)
 S:	Maintained
+F:	sound/oao/
 
 APM DRIVER
 P:	Stephen Rothwell
