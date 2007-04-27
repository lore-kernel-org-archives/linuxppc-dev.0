Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2F46FDE067
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Apr 2007 08:00:03 +1000 (EST)
Subject: [PATCH] powerpc: put enable_kernel_spe into a header
From: Johannes Berg <johannes@sipsolutions.net>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <1177710883.3565.66.camel@johannes.berg>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1177710095.3565.64.camel@johannes.berg>
	<20070427215338.GB17224@lixom.net>
	<1177710883.3565.66.camel@johannes.berg>
Content-Type: text/plain
Date: Sat, 28 Apr 2007 00:00:03 +0200
Message-Id: <1177711203.3565.70.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch puts enable_kernel_spe into <asm-powerpc/system.h> along with
enable_kernel_altivec etc.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
 include/asm-powerpc/system.h |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.orig/include/asm-powerpc/system.h	2007-04-27 23:56:42.976021121 +0200
+++ linux-2.6/include/asm-powerpc/system.h	2007-04-27 23:59:50.826021121 +0200
@@ -131,6 +131,7 @@ extern void enable_kernel_altivec(void);
 extern void giveup_altivec(struct task_struct *);
 extern void load_up_altivec(struct task_struct *);
 extern int emulate_altivec(struct pt_regs *);
+extern void enable_kernel_spe(void);
 extern void giveup_spe(struct task_struct *);
 extern void load_up_spe(struct task_struct *);
 extern int fix_alignment(struct pt_regs *);
