Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BmhS2dDMzDqh1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 01:04:22 +1100 (AEDT)
Date: Thu, 29 Mar 2018 10:04:14 -0400 (EDT)
Message-Id: <20180329.100414.1839699928682052200.davem@davemloft.net>
To: okaya@codeaurora.org
Cc: benh@kernel.crashing.org, torvalds@linux-foundation.org,
 alexander.duyck@gmail.com, will.deacon@arm.com, arnd@arndb.de,
 jgg@ziepe.ca, David.Laight@aculab.com, oohall@gmail.com,
 linuxppc-dev@lists.ozlabs.org, linux-rdma@vger.kernel.org,
 alexander.h.duyck@redhat.com, paulmck@linux.vnet.ibm.com,
 netdev@vger.kernel.org, linus971@gmail.com
Subject: Re: RFC on writel and writel_relaxed
From: David Miller <davem@davemloft.net>
In-Reply-To: <29fe17e0-9978-dc43-d02c-de8fabdc66c2@codeaurora.org>
References: <1522249996.21446.25.camel@kernel.crashing.org>
 <20180328.115509.481837809903086401.davem@davemloft.net>
 <29fe17e0-9978-dc43-d02c-de8fabdc66c2@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sinan Kaya <okaya@codeaurora.org>
Date: Thu, 29 Mar 2018 09:56:01 -0400

> sparc		question sent

Sparc never lets physical memory accesses pass MMIO, and vice versa.

They are always strongly ordered amongst eachother.

Therefore no explicit barrier instructions are necessary.
