Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0206.outbound.protection.outlook.com [207.46.163.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A644C1A0703
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 May 2014 09:00:33 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] MAINTAINERS: Update Linux for Freescale PowerPC
Date: Fri, 30 May 2014 18:00:11 -0500
Message-ID: <1401490811-14057-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

About a year ago I began taking patches, technically as Kumar's
assistant -- but since then all of the pull requests for this area have
come from me, and I've been doing most of the reviews.  Update
MAINTAINERS to reflect this.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 049214e..5509f3f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5341,9 +5341,11 @@ S:	Maintained
 F:	arch/powerpc/platforms/8xx/
 
 LINUX FOR POWERPC EMBEDDED PPC83XX AND PPC85XX
+M:	Scott Wood <scottwood@freescale.com>
 M:	Kumar Gala <galak@kernel.crashing.org>
 W:	http://www.penguinppc.org/
 L:	linuxppc-dev@lists.ozlabs.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git
 S:	Maintained
 F:	arch/powerpc/platforms/83xx/
 F:	arch/powerpc/platforms/85xx/
-- 
1.9.1
