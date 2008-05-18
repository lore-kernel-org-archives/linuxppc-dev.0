Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 67059DDE21
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 04:45:05 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: paulus@samba.org
Subject: [PATCH 3/4] [POWERPC] Update arch/powerpc/boot/.gitignore
Date: Sun, 18 May 2008 13:44:55 -0500
Message-Id: <1211136296-4572-4-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1211136296-4572-3-git-send-email-galak@kernel.crashing.org>
References: <1211136296-4572-1-git-send-email-galak@kernel.crashing.org>
	<1211136296-4572-2-git-send-email-galak@kernel.crashing.org>
	<1211136296-4572-3-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Add dtbImage.*
* Simplify zImages to zImage and zImage.*

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/.gitignore |   15 ++-------------
 1 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
index 2347294..ea2fcaf 100644
--- a/arch/powerpc/boot/.gitignore
+++ b/arch/powerpc/boot/.gitignore
@@ -20,21 +20,10 @@ kernel-vmlinux.strip.gz
 mktree
 uImage
 cuImage.*
+dtbImage.*
 treeImage.*
 zImage
-zImage.bin.*
-zImage.chrp
-zImage.coff
-zImage.coff.lds
-zImage.ep*
-zImage.iseries
-zImage.*lds
-zImage.miboot
-zImage.pmac
-zImage.pseries
-zImage.redboot*
-zImage.sandpoint
-zImage.vmode
+zImage.*
 zconf.h
 zlib.h
 zutil.h
-- 
1.5.4.5
