Return-Path: <sowmini.varadhan@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9AD3A1A03D3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 23:52:09 +1100 (AEDT)
Date: Thu, 2 Apr 2015 08:51:52 -0400
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v8 RFC 0/3] Generic IOMMU pooled allocator
Message-ID: <20150402125152.GA17528@oracle.com>
References: <20150331180642.GA13314@oracle.com>
 <1427850091.20500.150.camel@kernel.crashing.org>
 <551B4502.1020603@oracle.com>
 <20150331.231224.402909066860518278.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150331.231224.402909066860518278.davem@davemloft.net>
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

On (03/31/15 23:12), David Miller wrote:
> 
> It's much more amortized with smart buffering strategies, which are
> common on current generation networking cards.
> 
> There you only eat one map/unmap per "PAGE_SIZE / rx_pkt_size".
> 
> Maybe the infiniband stuff is doing things very suboptimally, and
> actually with that subsystem and drivers absolutely nothing would
> surprise me.

yeh, we are trying to get more info from them about what their
bottle-necks are. Until then, lets just stick with the spin_lock.

do I need to resubmit this without the RFC tag? Perhaps I should
have dropped that some time ago.

--Sowmini
