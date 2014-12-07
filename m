Return-Path: <rickard_strandqvist@spectrumdigital.se>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
 [209.85.212.173])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A77201A023F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 09:29:05 +1100 (AEDT)
Received: by mail-wi0-f173.google.com with SMTP id r20so3199863wiv.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Dec 2014 14:29:02 -0800 (PST)
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH] arch: powerpc: kernel: vio.c:  Remove unused function
Date: Sun,  7 Dec 2014 23:31:42 +0100
Message-Id: <1417991502-20223-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Cc: devicetree@vger.kernel.org, Li Zhong <zhong@linux.vnet.ibm.com>,
 Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Daniel Walter <dwalter@google.com>, Alistair Popple <alistair@popple.id.au>,
 Grant Likely <grant.likely@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the function cmo_high_show() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/powerpc/kernel/vio.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 5bfdab9..11657d2 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1032,11 +1032,6 @@ viobus_cmo_pool_rd_attr(reserve, size);
 viobus_cmo_pool_rd_attr(excess, size);
 viobus_cmo_pool_rd_attr(excess, free);
 
-static ssize_t cmo_high_show(struct bus_type *bt, char *buf)
-{
-	return sprintf(buf, "%lu\n", vio_cmo.high);
-}
-
 static ssize_t cmo_high_store(struct bus_type *bt, const char *buf,
 			      size_t count)
 {
-- 
1.7.10.4
