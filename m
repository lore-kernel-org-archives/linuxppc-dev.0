Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 8DC54B6F71
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Jul 2011 15:04:44 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: change maintainership of mpc5xxx
Date: Thu, 21 Jul 2011 07:04:25 +0200
Message-Id: <1311224665-19159-1-git-send-email-agust@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant intends to hand over maintainership of mpc5xxx
to me. Change MPC5XXX entry in MAINTAINERS accordingly.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 MAINTAINERS |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 187282d..323208d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3878,9 +3878,9 @@ F:	arch/powerpc/platforms/powermac/
 F:	drivers/macintosh/
 
 LINUX FOR POWERPC EMBEDDED MPC5XXX
-M:	Grant Likely <grant.likely@secretlab.ca>
+M:	Anatolij Gustschin <agust@denx.de>
 L:	linuxppc-dev@lists.ozlabs.org
-T:	git git://git.secretlab.ca/git/linux-2.6.git
+T:	git git://git.denx.de/linux-2.6-agust.git
 S:	Maintained
 F:	arch/powerpc/platforms/512x/
 F:	arch/powerpc/platforms/52xx/
-- 
1.7.1
