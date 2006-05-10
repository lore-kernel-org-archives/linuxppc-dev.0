Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (dsl027-180-168.sfo1.dsl.speakeasy.net
	[216.27.180.168]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7648B679E2
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 16:45:19 +1000 (EST)
Date: Tue, 09 May 2006 23:22:15 -0700 (PDT)
Message-Id: <20060509.232215.69573210.davem@davemloft.net>
To: olof@lixom.net
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060510051649.GD1794@lixom.net>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
	<20060510051649.GD1794@lixom.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Olof Johansson <olof@lixom.net>
Date: Wed, 10 May 2006 00:16:50 -0500

> It would be interesting to see benchmarks of how much it improves
> things. I guess it doesn't really get interesting until after the paca
> gets removed though, due to the added mfsprg's.

When I moved the per-cpu base into a fixed register on sparc64,
it definitely showed up on the micro-benchmarks because this
shrunk the .text a lot in that case.
