Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 72AFE2C045B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 22:09:51 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Mon, 18 Nov 2013 16:39:47 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 8C2B73940057
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 16:39:43 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAIB9fpg39387384
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 16:39:41 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAIB9g48024954
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 16:39:42 +0530
Received: from hegdevasant.in.ibm.com (hegdevasant.in.ibm.com [9.124.35.106]
 (may be forged))
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 rAIB9gJ2024951
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 16:39:42 +0530
Subject: [PATCH] powerpc/powernv: Update dump README file
To: linuxppc-dev@lists.ozlabs.org
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Date: Mon, 18 Nov 2013 16:39:42 +0530
Message-ID: <20131118110938.30746.45067.stgit@hegdevasant.in.ibm.com>
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

Update dump README file content.

Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal-dump.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-dump.c b/arch/powerpc/platforms/powernv/opal-dump.c
index e102a80..9bc8ad3 100644
--- a/arch/powerpc/platforms/powernv/opal-dump.c
+++ b/arch/powerpc/platforms/powernv/opal-dump.c
@@ -317,9 +317,17 @@ static struct notifier_block dump_nb = {
 };
 
 
-/* FIXME: debugfs README message */
+/* debugfs README message */
 static const char readme_msg[] =
-	"This file will be populated shortly..";
+	"Platform dump HOWTO:\n\n"
+	"files:\n"
+	"  dump                  - Binary file, contains actual dump data\n"
+	"  dump_available (r--)  - New dump available notification\n"
+	"                          0 : No dump present\n"
+	"                          1 : Dump present\n"
+	"  dump_control(-w-)     - Dump control file\n"
+	"                          1 : Send acknowledgement (dump copied)\n"
+	"                          2 : Initiate FipS dump\n";
 
 /* debugfs dump_control file operations */
 static ssize_t dump_control_write(struct file *file,
