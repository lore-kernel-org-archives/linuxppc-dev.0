Return-Path: <justinmattock@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 86E3FB70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Feb 2011 17:10:43 +1100 (EST)
Received: by iwc10 with SMTP id 10so885714iwc.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Feb 2011 22:10:37 -0800 (PST)
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: trivial@kernel.org
Subject: [PATCH 03/21]arch:powerpc:eeh.c remove one to many l's in the word.
Date: Thu, 24 Feb 2011 22:10:18 -0800
Message-Id: <1298614218-3532-1-git-send-email-justinmattock@gmail.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
	"Justin P. Mattock" <justinmattock@gmail.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch below removes an extra "l" in the word.

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
 arch/powerpc/platforms/pseries/eeh.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 17a11c8..3cc4d10 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -876,7 +876,7 @@ void eeh_restore_bars(struct pci_dn *pdn)
  *
  * Save the values of the device bars. Unlike the restore
  * routine, this routine is *not* recursive. This is because
- * PCI devices are added individuallly; but, for the restore,
+ * PCI devices are added individually; but, for the restore,
  * an entire slot is reset at a time.
  */
 static void eeh_save_bars(struct pci_dn *pdn)
-- 
1.7.4.1
