Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 917911A013C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 13:25:20 +1100 (AEDT)
Date: Wed, 18 Mar 2015 22:25:17 -0400 (EDT)
Message-Id: <20150318.222517.1444725543017433108.davem@davemloft.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: Generic IOMMU pooled allocator
From: David Miller <davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sparclinux@vger.kernel.org, paulus@samba.org, sowmini.varadhan@oracle.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


PowerPC folks, we're trying to kill the locking contention in our
IOMMU allocators and noticed that you guys have a nice solution to
this in your IOMMU code.

Sowmini put together a patch series that tries to extract out the
generic parts of your code and place it in lib/iommu-common.c so
that both Sparc and PowerPC can make use of it.

The real test is if powerpc can be converted to use it.

So if you guys could please take a look at the current version of
this series at:

http://patchwork.ozlabs.org/patch/449712/
http://patchwork.ozlabs.org/patch/449713/
http://patchwork.ozlabs.org/patch/449715/

and give us some feedback that would be great.

After we sort out making this work properly for both architectures we
can figure out who merges which parts via what tree(s).

Thanks!
