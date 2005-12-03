Return-Path: <otavio@debian.org>
Received: from aveiro.procergs.com.br (aveiro.procergs.com.br [200.198.128.42])
	by ozlabs.org (Postfix) with ESMTP id D8A256885E
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Dec 2005 06:07:08 +1100 (EST)
In-Reply-To: 
Date: Sat, 3 Dec 2005 17:07:06 -0200
Message-Id: <11336368261610-git-send-email-otavio@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linuxppc-dev@ozlabs.org,  akpm@osdl.org
From: Otavio Salvador <otavio@debian.org>
Cc: Otavio Salvador <otavio@debian.org>
Subject: [PATCH] include/asm-ppc/btext.h: add prototype of btext_init
	function.
Reply-To: Otavio Salvador <otavio@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The prototype of btext_init function was missing and then caused a compile
warning.

---

 include/asm-ppc/btext.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

applies-to: 60e8ae37378de2772b6b0768b12a49f923710152
786b869f9cfd4c1f82fbc8b20fa8cafb9188e12f
diff --git a/include/asm-ppc/btext.h b/include/asm-ppc/btext.h
index ccaefab..2329331 100644
--- a/include/asm-ppc/btext.h
+++ b/include/asm-ppc/btext.h
@@ -18,6 +18,7 @@ extern boot_infos_t disp_bi;
 extern int boot_text_mapped;
 
 extern void init_boot_display(void);
+extern void __init btext_init(boot_infos_t *bi);
 extern void btext_welcome(void);
 extern void btext_prepare_BAT(void);
 extern void btext_setup_display(int width, int height, int depth, int pitch,
---
0.99.9k
