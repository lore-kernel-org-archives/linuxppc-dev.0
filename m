Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BCBt5512zF2Dm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 02:55:14 +1100 (AEDT)
Date: Wed, 28 Mar 2018 11:55:09 -0400 (EDT)
Message-Id: <20180328.115509.481837809903086401.davem@davemloft.net>
To: benh@kernel.crashing.org
Cc: okaya@codeaurora.org, torvalds@linux-foundation.org,
 alexander.duyck@gmail.com, will.deacon@arm.com, arnd@arndb.de,
 jgg@ziepe.ca, David.Laight@aculab.com, oohall@gmail.com,
 linuxppc-dev@lists.ozlabs.org, linux-rdma@vger.kernel.org,
 alexander.h.duyck@redhat.com, paulmck@linux.vnet.ibm.com,
 netdev@vger.kernel.org, linus971@gmail.com
Subject: Re: RFC on writel and writel_relaxed
From: David Miller <davem@davemloft.net>
In-Reply-To: <1522249996.21446.25.camel@kernel.crashing.org>
References: <CA+55aFxULkhZGhg-tTBBxBBvXbL7QV7f6zvwW7U2wHFijqGEqw@mail.gmail.com>
 <b02cc752d90c5e5ae2cc8cc4f67429a7@codeaurora.org>
 <1522249996.21446.25.camel@kernel.crashing.org>
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

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 29 Mar 2018 02:13:16 +1100

> Let's fix all archs, it's way easier than fixing all drivers. Half of
> the archs are unused or dead anyway.

Agreed.
