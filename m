Return-Path: <esben.haabendal@gmail.com>
Received: from mail-la0-x22c.google.com (mail-la0-x22c.google.com
 [IPv6:2a00:1450:4010:c03::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 394E01A078E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jan 2015 22:27:15 +1100 (AEDT)
Received: by mail-la0-f44.google.com with SMTP id gd6so19886501lab.31
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Jan 2015 03:27:11 -0800 (PST)
Sender: Esben Haabendal <esbenhaabendal@gmail.com>
From: esben.haabendal@gmail.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 3/3] powerpc: Add .gitignore entry for built DTB files
Date: Tue,  6 Jan 2015 12:27:00 +0100
Message-Id: <1420543620-20658-3-git-send-email-esben.haabendal@gmail.com>
In-Reply-To: <1420543620-20658-1-git-send-email-esben.haabendal@gmail.com>
References: <1420543620-20658-1-git-send-email-esben.haabendal@gmail.com>
Cc: Esben Haabendal <eha@deif.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Esben Haabendal <eha@deif.com>

Signed-off-by: Esben Haabendal <eha@deif.com>
---
 arch/powerpc/boot/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
index d61c035..38e6492 100644
--- a/arch/powerpc/boot/.gitignore
+++ b/arch/powerpc/boot/.gitignore
@@ -29,6 +29,7 @@ zImage.*lds
 zImage.miboot
 zImage.pmac
 zImage.pseries
+*.dtb
 zconf.h
 zlib.h
 zutil.h
-- 
2.1.4
