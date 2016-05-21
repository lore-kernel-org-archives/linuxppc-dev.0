Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lb0-x244.google.com (mail-lb0-x244.google.com
 [IPv6:2a00:1450:4010:c04::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBjYV1S5nzDqKT
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 21:41:02 +1000 (AEST)
Received: by mail-lb0-x244.google.com with SMTP id mx9so6860677lbb.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 04:41:02 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, jk@ozlabs.org, corbet@lwn.net,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org
Subject: [PATCH 0039/1529] Fix typo
Date: Sat, 21 May 2016 13:40:54 +0200
Message-Id: <20160521114054.927-1-andrea.gelmini@gelma.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/filesystems/spufs.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/spufs.txt b/Documentation/filesystems/spufs.txt
index 1343d11..cbbe795 100644
--- a/Documentation/filesystems/spufs.txt
+++ b/Documentation/filesystems/spufs.txt
@@ -105,7 +105,7 @@ FILES
 
 
    /wbox
-       The CPU to SPU communation mailbox. It is write-only and can be written
+       The CPU to SPU communication mailbox. It is write-only and can be written
        in  units  of  32  bits. If the mailbox is full, write() will block and
        poll can be used to wait for it becoming  empty  again.   The  possible
        operations  on  an open wbox file are: write(2) If a count smaller than
-- 
2.8.2.534.g1f66975
