Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id B9DAD1A01EE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 08:38:12 +1000 (AEST)
Date: Wed, 23 Sep 2015 15:38:09 -0700 (PDT)
Message-Id: <20150923.153809.1811725480176067437.davem@davemloft.net>
To: christophe.leroy@c-s.fr
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 scottwood@freescale.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/9] powerpc32: set of optimisation of network checksum
 functions
From: David Miller <davem@davemloft.net>
In-Reply-To: <cover.1442876807.git.christophe.leroy@c-s.fr>
References: <cover.1442876807.git.christophe.leroy@c-s.fr>
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

From: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Tue, 22 Sep 2015 16:34:17 +0200 (CEST)

> This patch serie gather patches related to checksum functions on powerpc.
> Some of those patches have already been submitted individually.

I'm assuming that the powerpc folks will integrate this series.

Let me know if I should take it into net-next instead.

Thanks.
