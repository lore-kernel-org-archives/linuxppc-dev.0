Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1A0F7B6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 May 2012 03:43:48 +1000 (EST)
Date: Mon, 30 Apr 2012 13:41:40 -0400 (EDT)
Message-Id: <20120430.134140.1738751315208907289.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [REGRESSION][PATCH V4 3/3] bpf jit: Let the powerpc jit handle
 negative offsets
From: David Miller <davem@davemloft.net>
In-Reply-To: <1335763568.20866.37.camel@pasglop>
References: <1335760199.20866.33.camel@pasglop> <4F9E188E.80503@googlemail.com>
 <1335763568.20866.37.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: kaffeemonster@googlemail.com, eric.dumazet@gmail.com, matt@ozlabs.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 30 Apr 2012 15:26:08 +1000

> David, what's the right way to fix that ?

There is no doubt that sock_fprog is the correct datastructure to use.
