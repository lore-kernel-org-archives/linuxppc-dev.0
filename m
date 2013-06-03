Return-Path: <Ian.Campbell@citrix.com>
Received: from SMTP.EU.CITRIX.COM (smtp.eu.citrix.com [46.33.159.39])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "Cisco Appliance Demo Certificate",
 Issuer "Cisco Appliance Demo Certificate" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AAF7E2C02F5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jun 2013 21:01:00 +1000 (EST)
From: Ian Campbell <ian.campbell@citrix.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/boot: Ignore .dtb files.
Date: Mon, 3 Jun 2013 12:00:56 +0100
Message-ID: <1370257256-24045-1-git-send-email-ian.campbell@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Ian Campbell <ian.campbell@citrix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
---
 arch/powerpc/boot/.gitignore |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
index c32ae5c..8fa258e 100644
--- a/arch/powerpc/boot/.gitignore
+++ b/arch/powerpc/boot/.gitignore
@@ -16,6 +16,7 @@ mktree
 uImage
 cuImage.*
 dtbImage.*
+*.dtb
 treeImage.*
 zImage
 zImage.initrd
-- 
1.7.10.4
