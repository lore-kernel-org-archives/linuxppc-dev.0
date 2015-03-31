Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id B918E1A0743
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 05:08:52 +1100 (AEDT)
Date: Tue, 31 Mar 2015 14:08:48 -0400 (EDT)
Message-Id: <20150331.140848.1629977835564626654.davem@davemloft.net>
To: sowmini.varadhan@oracle.com
Subject: Re: [PATCH v8 RFC 0/3] Generic IOMMU pooled allocator
From: David Miller <davem@davemloft.net>
In-Reply-To: <20150331180642.GA13314@oracle.com>
References: <cover.1427761300.git.sowmini.varadhan@oracle.com>
 <20150331180642.GA13314@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 31 Mar 2015 14:06:42 -0400

> Having bravely said that..
> 
> the IB team informs me that they see a 10% degradation using 
> the spin_lock as opposed to the trylock.
> 
> one path going forward is to continue processing this patch-set 
> as is. I can investigate this further, and later revise the spin_lock
> to the trylock, after we are certain that it is good/necessary.
> 
> thoughts?

Let's address the trylock vs. spin_lock thing later and use plain
spin_lock for now.
