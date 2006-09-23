Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EB99667BB1
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Sep 2006 10:37:45 +1000 (EST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat
	Linux)) id 1GQvWX-0002eC-Pq
	for linuxppc-dev@ozlabs.org; Sat, 23 Sep 2006 01:37:41 +0100
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] NULL noise removal: spufs
Message-Id: <E1GQvWX-0002eC-Pq@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Sat, 23 Sep 2006 01:37:41 +0100
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/platforms/cell/spufs/file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 58e794f..51fd197 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -1342,7 +1342,7 @@ static u64 spufs_id_get(void *data)
 
 	return num;
 }
-DEFINE_SIMPLE_ATTRIBUTE(spufs_id_ops, spufs_id_get, 0, "0x%llx\n")
+DEFINE_SIMPLE_ATTRIBUTE(spufs_id_ops, spufs_id_get, NULL, "0x%llx\n")
 
 struct tree_descr spufs_dir_contents[] = {
 	{ "mem",  &spufs_mem_fops,  0666, },
-- 
1.4.2.GIT
