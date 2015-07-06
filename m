Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 18AB71A0452
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2015 14:10:26 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Mon, 6 Jul 2015 14:10:24 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 36E653578048
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2015 14:10:19 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t664A9Yf3080660
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jul 2015 14:10:19 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6649j3b019766
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jul 2015 14:09:45 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH slof] README: Update with patch submittion note
Date: Mon,  6 Jul 2015 14:09:10 +1000
Message-Id: <1436155750-16815-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds a maillist and emails to be used when posting a patch for SLOF.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

I was asked to describe somewhere how to post new patches so this is the first
attempt. Please fix my english and add/remove personal emails and any other
comments are also welcome. Thanks!

---
 README | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/README b/README
index 58e9294..b81fd08 100644
--- a/README
+++ b/README
@@ -11,6 +11,7 @@ Index
 2.2 Overview of the source code
 2.4 Extending the Forth engine
 3.0 Limitations
+4.0 Submitting patches
 
 
 1.0 Introduction to Slimline Open Firmware
@@ -236,6 +237,15 @@ To add primitives:
  On a JS21 all memory configurations should work.
 
 
+4.0 Submitting patches
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+
+Patches for SLOF should be made against https://github.com/aik/SLOF,
+the master branch and posted to linuxppc-dev@ozlabs.org. It is
+recommended also cc: to aik@ozlabs.ru, nikunj@linux.vnet.ibm.com,
+thuth@redhat.com.
+
+
 Documentation
 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 
-- 
2.4.0.rc3.8.gfb3e7d5
