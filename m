Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1050.oracle.com (aserp1050.oracle.com [141.146.126.70])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 810471A0039
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 01:42:45 +1000 (EST)
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by aserp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 s59FJ2C8027059
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jun 2014 15:19:03 GMT
Date: Mon, 9 Jun 2014 18:18:52 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch] powerpc/cpm: remove duplicate FCC_GFMR_TTX define
Message-ID: <20140609151852.GL9600@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The FCC_GFMR_TTX define is cut and pasted twice so we can remove the
second instance.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/powerpc/include/asm/cpm2.h b/arch/powerpc/include/asm/cpm2.h
index f42e9ba..7c8608b 100644
--- a/arch/powerpc/include/asm/cpm2.h
+++ b/arch/powerpc/include/asm/cpm2.h
@@ -489,7 +489,6 @@ typedef struct scc_trans {
 #define FCC_GFMR_TCI		((uint)0x20000000)
 #define FCC_GFMR_TRX		((uint)0x10000000)
 #define FCC_GFMR_TTX		((uint)0x08000000)
-#define FCC_GFMR_TTX		((uint)0x08000000)
 #define FCC_GFMR_CDP		((uint)0x04000000)
 #define FCC_GFMR_CTSP		((uint)0x02000000)
 #define FCC_GFMR_CDS		((uint)0x01000000)
