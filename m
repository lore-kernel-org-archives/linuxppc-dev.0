Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id C9252DDDEB
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 14:30:50 +1100 (EST)
Date: Tue, 19 Feb 2008 19:31:25 -0800 (PST)
Message-Id: <20080219.193125.04536962.davem@davemloft.net>
To: galak@kernel.crashing.org
Subject: Re: [PATCH v2][POWERPC] Fix initial lmb add region with a non-zero
	base
From: David Miller <davem@davemloft.net>
In-Reply-To: <4130F47E-4F4A-4911-B63B-403A8C423565@kernel.crashing.org>
References: <Pine.LNX.4.64.0802191350590.10089@blarg.am.freescale.net>
	<20080219.163003.152862383.davem@davemloft.net>
	<4130F47E-4F4A-4911-B63B-403A8C423565@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kumar Gala <galak@kernel.crashing.org>
Date: Tue, 19 Feb 2008 21:02:04 -0600

> np.  Are we trying to get this into 2.6.25 or .26?

I'm ambivalent but I would obviously prefer 2.6.25 because
it would allow me to proceed more easily with my sparc64
NUMA work as well as get your bug fixes in more smoothly.
