Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DFC1C68AA7
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2006 18:11:04 +1100 (EST)
To: linux-kernel@vger.kernel.org
Subject: [PATCH 11/17] __user annotations in powerpc thread_info
Message-Id: <E1F6jTh-0002cN-1v@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 07:11:01 +0000
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Date: 1138796974 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 include/asm-powerpc/thread_info.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

e795638bb9e81bae80bbe88b74c8ee0d1b1d8d3c
diff --git a/include/asm-powerpc/thread_info.h b/include/asm-powerpc/thread_info.h
index 67cdaf3..c044ec1 100644
--- a/include/asm-powerpc/thread_info.h
+++ b/include/asm-powerpc/thread_info.h
@@ -37,7 +37,7 @@ struct thread_info {
 	int		preempt_count;		/* 0 => preemptable,
 						   <0 => BUG */
 	struct restart_block restart_block;
-	void *nvgprs_frame;
+	void __user *nvgprs_frame;
 	/* low level flags - has atomic operations done on it */
 	unsigned long	flags ____cacheline_aligned_in_smp;
 };
-- 
0.99.9.GIT
