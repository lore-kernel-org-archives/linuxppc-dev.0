Return-Path: <joe@perches.com>
Received: from mail.perches.com (mail.perches.com [173.55.12.10])
	by ozlabs.org (Postfix) with ESMTP id 48F21B7145
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 31 Oct 2010 08:09:24 +1100 (EST)
From: Joe Perches <joe@perches.com>
To: Jiri Kosina <trivial@kernel.org>
Subject: [PATCH 04/39] arch/powerpc: Update WARN uses
Date: Sat, 30 Oct 2010 14:08:21 -0700
Message-Id: <c6c46b5924e1cc9720d3ad76e6c11e982bd661e5.1288471898.git.joe@perches.com>
In-Reply-To: <cover.1288471897.git.joe@perches.com>
References: <cover.1288471897.git.joe@perches.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Coalesce long formats.
Align arguments.
Add missing newlines.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/powerpc/kernel/hw_breakpoint.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 5ecd040..d7343a7 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -270,8 +270,8 @@ int __kprobes hw_breakpoint_handler(struct die_args *args)
 	 * message to let the user know about it.
 	 */
 	if (!stepped) {
-		WARN(1, "Unable to handle hardware breakpoint. Breakpoint at "
-			"0x%lx will be disabled.", info->address);
+		WARN(1, "Unable to handle hardware breakpoint. Breakpoint at 0x%lx will be disabled.\n",
+		     info->address);
 		perf_event_disable(bp);
 		goto out;
 	}
-- 
1.7.3.1.g432b3.dirty
