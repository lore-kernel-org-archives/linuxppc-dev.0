Return-Path: <felix@linux.vnet.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0AB7F1A011B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 21:46:19 +1100 (AEDT)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Thu, 26 Mar 2015 10:46:16 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 03AA02190056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 10:46:02 +0000 (GMT)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2QAkDxs10551630
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 10:46:13 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2QAkCJK021343
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 04:46:13 -0600
Message-ID: <5513E3A0.6060001@linux.vnet.ibm.com>
Date: Thu, 26 Mar 2015 11:46:56 +0100
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] cxl: Fix a typo in ABI documentation
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix the attribute name of the configuration record class ID.

Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
---
  Documentation/ABI/testing/sysfs-class-cxl | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
index 3680364..d46bba8 100644
--- a/Documentation/ABI/testing/sysfs-class-cxl
+++ b/Documentation/ABI/testing/sysfs-class-cxl
@@ -100,7 +100,7 @@ Description:    read only
  		Hexadecimal value of the device ID found in this AFU
  		configuration record.

-What:           /sys/class/cxl/<afu>/cr<config num>/vendor
+What:           /sys/class/cxl/<afu>/cr<config num>/class
  Date:           February 2015
  Contact:        linuxppc-dev@lists.ozlabs.org
  Description:    read only
-- 1.8.3.1
