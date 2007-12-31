Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6F129DDE98
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jan 2008 03:14:12 +1100 (EST)
Message-ID: <4779157D.2040305@scram.de>
Date: Mon, 31 Dec 2007 17:14:53 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Update .gitignore files.
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Update .gitignore as needed by dtc addition.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/powerpc/boot/.gitignore         |    1 +
 arch/powerpc/boot/dtc-src/.gitignore |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dtc-src/.gitignore

diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
index 65f4118..b160322 100644
--- a/arch/powerpc/boot/.gitignore
+++ b/arch/powerpc/boot/.gitignore
@@ -1,4 +1,5 @@
 addnote
+dtc
 empty.c
 hack-coff
 infblock.c
diff --git a/arch/powerpc/boot/dtc-src/.gitignore b/arch/powerpc/boot/dtc-src/.gitignore
new file mode 100644
index 0000000..a7c3f94
--- /dev/null
+++ b/arch/powerpc/boot/dtc-src/.gitignore
@@ -0,0 +1,3 @@
+dtc-lexer.lex.c
+dtc-parser.tab.c
+dtc-parser.tab.h
-- 
1.5.3.7
