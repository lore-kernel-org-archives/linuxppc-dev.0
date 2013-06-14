Return-Path: <joe@perches.com>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
 (using SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 295C32C030A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 12:38:58 +1000 (EST)
From: Joe Perches <joe@perches.com>
To: Jiri Kosina <trivial@kernel.org>
Subject: [Trivial PATCH 05/33] powerpc: idle: Convert use of typedef ctl_table
 to struct ctl_table
Date: Thu, 13 Jun 2013 19:37:30 -0700
Message-Id: <5e6452662144ad4c21bf817beeac0c1a32793c5c.1371177118.git.joe@perches.com>
In-Reply-To: <cover.1371177118.git.joe@perches.com>
References: <cover.1371177118.git.joe@perches.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This typedef is unnecessary and should just be removed.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/powerpc/kernel/idle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
index 939ea7e..d7216c9 100644
--- a/arch/powerpc/kernel/idle.c
+++ b/arch/powerpc/kernel/idle.c
@@ -85,7 +85,7 @@ int powersave_nap;
 /*
  * Register the sysctl to set/clear powersave_nap.
  */
-static ctl_table powersave_nap_ctl_table[]={
+static struct ctl_table powersave_nap_ctl_table[] = {
 	{
 		.procname	= "powersave-nap",
 		.data		= &powersave_nap,
@@ -95,7 +95,7 @@ static ctl_table powersave_nap_ctl_table[]={
 	},
 	{}
 };
-static ctl_table powersave_nap_sysctl_root[] = {
+static struct ctl_table powersave_nap_sysctl_root[] = {
 	{
 		.procname	= "kernel",
 		.mode		= 0555,
-- 
1.8.1.2.459.gbcd45b4.dirty
