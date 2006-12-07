Return-Path: <MAILER-DAEMON@rune.sasl.smtp.pobox.com>
Received: from lollipop.listbox.com (lollipop.listbox.com [208.210.124.78])
	by ozlabs.org (Postfix) with ESMTP id 5A1DD67BF8
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 13:53:59 +1100 (EST)
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by lollipop.listbox.com (Postfix) with ESMTP id C5F5348950C
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Dec 2006 19:51:18 -0500 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/4] maple: select PPC_RTAS
Date: Wed,  6 Dec 2006 18:50:44 -0600
Message-Id: <11654526511379-git-send-email-ntl@pobox.com>
In-Reply-To: <11654526463043-git-send-email-ntl@pobox.com>
References: <11654526463043-git-send-email-ntl@pobox.com>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some systems supported by the maple platform have RTAS; make PPC_MAPLE
select PPC_RTAS.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 291c95a..f524b3b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -470,6 +470,7 @@ config PPC_MAPLE
 	select PPC_UDBG_16550
 	select PPC_970_NAP
 	select PPC_NATIVE
+	select PPC_RTAS
 	default n
 	help
           This option enables support for the Maple 970FX Evaluation Board.
-- 
1.4.4.1
