Return-Path: <ananth@in.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 51D3C1A07E3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 20:52:21 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Fri, 17 Jul 2015 16:22:18 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 7ABAC1258061
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 16:25:11 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6HAqDPV31064208
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 16:22:13 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6HAqBTh004567
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 16:22:12 +0530
Subject: [PATCH V2 1/2] Documentation/features: Add na key to arch-support.txt
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: masami.hiramatsu.pt@hitachi.com, mpe@ellerman.id.au, mingo@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Fri, 17 Jul 2015 16:21:44 +0530
Message-ID: <20150717105139.29162.31467.stgit@thinktux.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To be used for features we will not support on a particular architecture.
The git log that adds this needs to provide the justification 'why?'

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
---
 Documentation/features/arch-support.txt |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/features/arch-support.txt b/Documentation/features/arch-support.txt
index d22a109..f2b272e 100644
--- a/Documentation/features/arch-support.txt
+++ b/Documentation/features/arch-support.txt
@@ -8,4 +8,5 @@ The meaning of entries in the tables is:
     | ok |  # feature supported by the architecture
     |TODO|  # feature not yet supported by the architecture
     | .. |  # feature cannot be supported by the hardware
+    | na |  # feature will not be supported by the architecture
 
