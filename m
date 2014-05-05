Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 399621402B5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 15:21:40 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Sun, 4 May 2014 23:21:36 -0600
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 8F59D38C8029
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 01:21:32 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s455LW1x2097536
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 05:21:32 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s455LVEE013110
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 01:21:32 -0400
Subject: [PATCH] powerpc: Fix comment around arch specific definition of
 RECLAIM_DISTANCE
To: linuxppc-dev@lists.ozlabs.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Mon, 05 May 2014 10:47:14 +0530
Message-ID: <20140505051713.7744.47492.stgit@preeti>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: anton@samba.org, kosaki.motohiro@jp.fujitsu.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 32e45ff43eaf5c17f changed the default value of
RECLAIM_DISTANCE to 30. However the comment around arch
specifc definition of RECLAIM_DISTANCE is not updated to
reflect the same. Correct the value mentioned in the comment.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
---

 arch/powerpc/include/asm/topology.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index c920215..356546d 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -12,7 +12,7 @@ struct device_node;
  * Before going off node we want the VM to try and reclaim from the local
  * node. It does this if the remote distance is larger than RECLAIM_DISTANCE.
  * With the default REMOTE_DISTANCE of 20 and the default RECLAIM_DISTANCE of
- * 20, we never reclaim and go off node straight away.
+ * 30, we never reclaim and go off node straight away.
  *
  * To fix this we choose a smaller value of RECLAIM_DISTANCE.
  */
