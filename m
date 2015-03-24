Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 0AD911A033E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 13:15:12 +1100 (AEDT)
Date: Mon, 23 Mar 2015 22:15:08 -0400 (EDT)
Message-Id: <20150323.221508.1178754097347144400.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: Generic IOMMU pooled allocator
From: David Miller <davem@davemloft.net>
In-Reply-To: <1427162890.4770.307.camel@kernel.crashing.org>
References: <1427149265.4770.238.camel@kernel.crashing.org>
 <20150323.214453.255192641139042325.davem@davemloft.net>
 <1427162890.4770.307.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: aik@au1.ibm.com, aik@ozlabs.ru, sowmini.varadhan@oracle.com,
 anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 24 Mar 2015 13:08:10 +1100

> For the large pool, we don't keep a hint so we don't know it's
> wrapped, in fact we purposefully don't use a hint to limit
> fragmentation on it, but then, it should be used rarely enough that
> flushing always is, I suspect, a good option.

I can't think of any use case where the largepool would be hit a lot
at all.
