Return-Path: <napohybelskurwysynom2010@gmail.com>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179]) by ozlabs.org (Postfix) with ESMTP id 9080EB70CC
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 23 Oct 2010 05:24:49 +1100 (EST)
Received: by gxk21 with SMTP id 21so1012256gxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Oct 2010 11:24:47 -0700 (PDT)
Message-ID: <4CC1D6EA.5060002@gmail.com>
Date: Fri, 22 Oct 2010 20:24:42 +0200
From: "N.P.S." <napohybelskurwysynom2010@gmail.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: [RFC][PATCH 6/8] Removal of dead code from
	arch/powerpc/kernel/process.c
References: <4CC1D2D5.9050009@gmail.com>
In-Reply-To: <4CC1D2D5.9050009@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 12747993cb2b4a07df7a62f247f20aa4a6263cd9
Author: N.P.S <napohybelskurwysynom2010@gmail.com>
Date:   Thu Oct 21 23:36:00 2010 +0200

    Removal of dead code from
    arch/powerpc/kernel/process.c
    
    Signed-off-by: Zimny Lech <napohybelskurwysynom2010@gmail.com>
    CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    CC: Paul Mackerras <paulus@samba.org>
    CC: <linuxppc-dev@lists.ozlabs.org>
    CC: <linux-kernel@vger.kernel.org>

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index b1c648a..e622887 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -670,12 +670,7 @@ void exit_thread(void)
 void flush_thread(void)
 {
 	discard_lazy_cpu_state();
-
-#ifdef CONFIG_HAVE_HW_BREAKPOINTS
-	flush_ptrace_hw_breakpoint(current);
-#else /* CONFIG_HAVE_HW_BREAKPOINTS */
 	set_debug_reg_defaults(&current->thread);
-#endif /* CONFIG_HAVE_HW_BREAKPOINTS */
 }
 
 void
