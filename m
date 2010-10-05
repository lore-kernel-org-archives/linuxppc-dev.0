Return-Path: <msm@freescale.com>
Received: from TX2EHSOBE002.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 58563B70D6
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Oct 2010 09:19:10 +1100 (EST)
Received: from mail127-tx2 (localhost.localdomain [127.0.0.1])	by
	mail127-tx2-R.bigfish.com (Postfix) with ESMTP id 73B4C17603A1	for
	<linuxppc-dev@lists.ozlabs.org>; Tue,  5 Oct 2010 22:18:52 +0000 (UTC)
Received: from TX2EHSMHS012.bigfish.com (unknown [10.9.14.236])	by
	mail127-tx2.bigfish.com (Postfix) with ESMTP id 4B4171A90056	for
	<linuxppc-dev@lists.ozlabs.org>; Tue,  5 Oct 2010 22:18:52 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o95MInvk023120	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 5 Oct 2010 15:18:49 -0700 (MST)
From: Matthew McClintock <msm@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/module: Remove unused variable err
Date: Tue, 5 Oct 2010 17:26:51 -0500
Message-ID: <1286317611-22822-1-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Matthew McClintock <msm@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 5336377d6225959624146629ce3fc88ee8ecda3d removed
the need for err, remove the variable

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 arch/powerpc/kernel/module.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
index 4ef93ae..49cee9d 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -63,7 +63,6 @@ int module_finalize(const Elf_Ehdr *hdr,
 		const Elf_Shdr *sechdrs, struct module *me)
 {
 	const Elf_Shdr *sect;
-	int err;
 
 	/* Apply feature fixups */
 	sect = find_section(hdr, sechdrs, "__ftr_fixup");
-- 
1.6.6.1
