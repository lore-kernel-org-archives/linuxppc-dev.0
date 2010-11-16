Return-Path: <alessioigorbogani@gmail.com>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179]) by ozlabs.org (Postfix) with ESMTP id AA479B7141
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Nov 2010 04:55:36 +1100 (EST)
Received: by eyg24 with SMTP id 24so474149eyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Nov 2010 09:55:33 -0800 (PST)
Sender: Alessio Igor Bogani <alessioigorbogani@gmail.com>
From: Alessio Igor Bogani <abogani@texware.it>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: Update a comment
Date: Tue, 16 Nov 2010 18:55:16 +0100
Message-Id: <1289930116-5702-1-git-send-email-abogani@texware.it>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	Tim Bird <tim.bird@am.sony.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Alessio Igor Bogani <abogani@texware.it>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The commit 5e3d20a remove bkl from startup code so setup_arch() it isn't called
with bkl held anymore. Update the comment on top of that function.
Fix also a typo.

This work was supported by a hardware donation from the CE Linux Forum.

Signed-off-by: Alessio Igor Bogani <abogani@texware.it>
---
 arch/powerpc/kernel/setup_64.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 2a178b0..ce6f61c 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -497,9 +497,8 @@ static void __init emergency_stack_init(void)
 }
 
 /*
- * Called into from start_kernel, after lock_kernel has been called.
- * Initializes bootmem, which is unsed to manage page allocation until
- * mem_init is called.
+ * Called into from start_kernel this initializes bootmem, which is used
+ * to manage page allocation until mem_init is called.
  */
 void __init setup_arch(char **cmdline_p)
 {
-- 
1.7.0.4
