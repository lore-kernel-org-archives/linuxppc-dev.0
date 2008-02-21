Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18364.57114.563431.730805@cargo.ozlabs.ibm.com>
Date: Thu, 21 Feb 2008 13:16:58 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2][POWERPC] Fix initial lmb add region with a non-zero
	base
In-Reply-To: <20080219.193125.04536962.davem@davemloft.net>
References: <Pine.LNX.4.64.0802191350590.10089@blarg.am.freescale.net>
	<20080219.163003.152862383.davem@davemloft.net>
	<4130F47E-4F4A-4911-B63B-403A8C423565@kernel.crashing.org>
	<20080219.193125.04536962.davem@davemloft.net>
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

David Miller writes:

> I'm ambivalent but I would obviously prefer 2.6.25 because
> it would allow me to proceed more easily with my sparc64
> NUMA work as well as get your bug fixes in more smoothly.

Sounds like we should get Stephen to put it in linux-next-stable once
we're convinced it's all OK.

Paul.
