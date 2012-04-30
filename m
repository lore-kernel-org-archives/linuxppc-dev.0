Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6B599B6FB9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 May 2012 03:43:55 +1000 (EST)
Date: Mon, 30 Apr 2012 13:41:48 -0400 (EDT)
Message-Id: <20120430.134148.722408249106132399.davem@davemloft.net>
To: kaffeemonster@googlemail.com
Subject: Re: [REGRESSION][PATCH V5 3/3] bpf jit: Let the powerpc jit handle
 negative offsets
From: David Miller <davem@davemloft.net>
In-Reply-To: <4F9E1CDB.9020104@googlemail.com>
References: <1335753820.20866.27.camel@pasglop>
 <1335759088.20866.32.camel@pasglop>
 <4F9E1CDB.9020104@googlemail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: eric.dumazet@gmail.com, matt@ozlabs.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jan Seiffert <kaffeemonster@googlemail.com>
Date: Mon, 30 Apr 2012 07:02:19 +0200

> Now the helper function from filter.c for negative offsets is exported,
> it can be used it in the jit to handle negative offsets.
> 
> First modify the asm load helper functions to handle:
> - know positive offsets
> - know negative offsets
> - any offset
> 
> then the compiler can be modified to explicitly use these helper
> when appropriate.
> 
> This fixes the case of a negative X register and allows to lift
> the restriction that bpf programs with negative offsets can't
> be jited.
> 
> Tested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Jan Seiffert <kaffeemonster@googlemail.com>

Applied, thanks.
