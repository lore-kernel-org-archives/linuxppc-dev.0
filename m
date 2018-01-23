Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQmNw3MqdzDr2M
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 22:32:16 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0NBVGtv114493
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 06:32:12 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fnyqxu5qf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 06:32:12 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 23 Jan 2018 11:32:10 -0000
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, mpe@ellerman.id.au,
 andrew.donnellan@au1.ibm.com, alastair@au1.ibm.com
Subject: [PATCH v2 13/13] ocxl: add MAINTAINERS entry
Date: Tue, 23 Jan 2018 12:31:48 +0100
In-Reply-To: <20180123113148.6024-1-fbarrat@linux.vnet.ibm.com>
References: <20180123113148.6024-1-fbarrat@linux.vnet.ibm.com>
Message-Id: <20180123113148.6024-14-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6e86e20761e..8a0357f3b7bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9820,6 +9820,18 @@ M:	Josh Poimboeuf <jpoimboe@redhat.com>
 S:	Supported
 F:	tools/objtool/
 
+OCXL (Open Coherent Accelerator Processor Interface OpenCAPI) DRIVER
+M:	Frederic Barrat <fbarrat@linux.vnet.ibm.com>
+M:	Andrew Donnellan <andrew.donnellan@au1.ibm.com>
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Supported
+F:	arch/powerpc/platforms/powernv/ocxl.c
+F:	arch/powerpc/include/asm/pnv-ocxl.h
+F:	drivers/misc/ocxl/
+F:	include/misc/ocxl*
+F:	include/uapi/misc/ocxl.h
+F:	Documentation/accelerators/ocxl.txt
+
 OMAP AUDIO SUPPORT
 M:	Peter Ujfalusi <peter.ujfalusi@ti.com>
 M:	Jarkko Nikula <jarkko.nikula@bitmer.com>
-- 
2.14.1
