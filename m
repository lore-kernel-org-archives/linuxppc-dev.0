Return-Path: <srs0=lavr=fq=au1.ibm.com=alastair@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmzjP5MkrzF17v
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 14:04:41 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zmzjP4Sx4z8tp9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 14:04:41 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zmzjP0ZNzz9sVw
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2018 14:04:40 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1M31rkA081481
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2018 22:04:39 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g9ffhuxsa-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2018 22:04:39 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <alastair@au1.ibm.com>;
 Thu, 22 Feb 2018 03:04:36 -0000
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: frederic.barrat@fr.ibm.com, andrew.donnellan@au1.ibm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, alastair@au1.ibm.com,
 "Alastair D'Silva" <alastair@d-silva.org>
Subject: [PATCH v2 0/2] Add get_metadata IOCTL to share OCXL information to
 userspace
Date: Thu, 22 Feb 2018 14:03:32 +1100
Message-Id: <20180222030334.14060-1-alastair@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alastair D'Silva <alastair@d-silva.org>

This series adds a new IOCTL for OpenCAPI, which exposes adapter
metadata to userspace.

--- 
v1->v2:
 - Document the new IOCTL

Alastair D'Silva (2):
  ocxl: Add get_metadata IOCTL to share OCXL information to userspace
  ocxl: Document the OCXL_IOCTL_GET_METADATA IOCTL

 Documentation/accelerators/ocxl.rst |  5 +++++
 drivers/misc/ocxl/file.c            | 27 +++++++++++++++++++++++++++
 include/uapi/misc/ocxl.h            | 22 ++++++++++++++++++++++
 3 files changed, 54 insertions(+)

-- 
2.14.3
