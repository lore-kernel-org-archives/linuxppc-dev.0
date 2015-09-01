Return-Path: <joel@jms.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 63C511A06F9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2015 14:23:25 +1000 (AEST)
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 99D0414076C
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Sep 2015 14:23:23 +1000 (AEST)
Received: by pacdd16 with SMTP id dd16so161957051pac.2
 for <linuxppc-dev@ozlabs.org>; Mon, 31 Aug 2015 21:23:22 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: anton@samba.org
Cc: linuxppc-dev@ozlabs.org
Subject: [kexec-lite 1/3] Add dependencies to the readme
Date: Tue,  1 Sep 2015 13:53:07 +0930
Message-Id: <1441081389-17131-1-git-send-email-joel@jms.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 README.md | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 9ca9ff2..4540d29 100644
--- a/README.md
+++ b/README.md
@@ -1,4 +1,11 @@
 kexec-lite
 ==========
 
-A simple kexec for flattened device tree platforms.
+A simple kexec for flattened device tree platforms, on PowerPC.
+
+Dependencies
+------------
+
+Requires Make, a C toolchain, and the libraries libelf and libfdt.
+
+```sudo apt-get install libelf-dev libfdt-dev```
-- 
2.5.0
