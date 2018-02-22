Return-Path: <srs0=lavr=fq=au1.ibm.com=alastair@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmzjT4mTPzF17v
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 14:04:45 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zmzjT2z3dz8tp9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 14:04:45 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zmzjS4fSbz9sVy
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2018 14:04:44 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1M2wx8O080097
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2018 22:04:42 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g9mr81r24-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2018 22:04:42 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <alastair@au1.ibm.com>;
 Thu, 22 Feb 2018 03:04:40 -0000
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: frederic.barrat@fr.ibm.com, andrew.donnellan@au1.ibm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, alastair@au1.ibm.com,
 "Alastair D'Silva" <alastair@d-silva.org>
Subject: [PATCH v2 2/2] ocxl: Document the OCXL_IOCTL_GET_METADATA IOCTL
Date: Thu, 22 Feb 2018 14:03:34 +1100
In-Reply-To: <20180222030334.14060-1-alastair@au1.ibm.com>
References: <20180222030334.14060-1-alastair@au1.ibm.com>
Message-Id: <20180222030334.14060-3-alastair@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alastair D'Silva <alastair@d-silva.org>

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 Documentation/accelerators/ocxl.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/accelerators/ocxl.rst b/Documentation/accelerators/ocxl.rst
index 4f7af841d935..ddcc58d01cfb 100644
--- a/Documentation/accelerators/ocxl.rst
+++ b/Documentation/accelerators/ocxl.rst
@@ -152,6 +152,11 @@ OCXL_IOCTL_IRQ_SET_FD:
   Associate an event fd to an AFU interrupt so that the user process
   can be notified when the AFU sends an interrupt.
 
+OCXL_IOCTL_GET_METADATA:
+
+  Obtains configuration information from the card, such at the size of
+  MMIO areas, the AFU version, and the PASID for the current context.
+
 
 mmap
 ----
-- 
2.14.3
