Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vmmvn52r6zDqjy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 17:56:53 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2K6maiO017715
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 02:56:47 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2990vw3dyp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 02:56:46 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 20 Mar 2017 16:56:44 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2K6uXdY44367906
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 17:56:41 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2K6u9Cm003674
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 17:56:09 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: keescook@chromium.org, re.emese@gmail.com,
 kernel-hardening@lists.openwall.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] gcc-plugins: update architecture list in documentation
Date: Mon, 20 Mar 2017 17:55:22 +1100
Message-Id: <20170320065522.14839-1-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 65c059bcaa73 ("powerpc: Enable support for GCC plugins") enabled GCC
plugins on powerpc, but neglected to update the architecture list in the
docs. Rectify this.

Fixes: 65c059bcaa73 ("powerpc: Enable support for GCC plugins")
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 Documentation/gcc-plugins.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gcc-plugins.txt b/Documentation/gcc-plugins.txt
index 891c69464434..433eaefb4aa1 100644
--- a/Documentation/gcc-plugins.txt
+++ b/Documentation/gcc-plugins.txt
@@ -18,8 +18,8 @@ because gcc versions 4.5 and 4.6 are compiled by a C compiler,
 gcc-4.7 can be compiled by a C or a C++ compiler,
 and versions 4.8+ can only be compiled by a C++ compiler.
 
-Currently the GCC plugin infrastructure supports only the x86, arm and arm64
-architectures.
+Currently the GCC plugin infrastructure supports only the x86, arm, arm64 and
+powerpc architectures.
 
 This infrastructure was ported from grsecurity [6] and PaX [7].
 
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
