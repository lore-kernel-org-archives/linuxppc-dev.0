Return-Path: <chris@void.printf.net>
Received: from void.printf.net (void.printf.net [89.145.121.20])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F19E7B6F07
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Sep 2010 08:01:54 +1000 (EST)
Date: Wed, 8 Sep 2010 22:37:41 +0100
From: Chris Ball <cjb@laptop.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/8] sdhci: Move real work out of an atomic context
Message-ID: <20100908213740.GA7550@void.printf.net>
References: <20100714130728.GA27339@oksana.dev.rtsoft.ru>
	<20100907153813.936db0c6.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100907153813.936db0c6.akpm@linux-foundation.org>
Cc: Matt Fleming <matt@console-pimps.org>,
	Albert Herranz <albert_herranz@yahoo.es>,
	Anton Vorontsov <avorontsov@mvista.com>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Ben Dooks <ben-linux@fluff.org>,
	Pierre Ossman <pierre@ossman.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andrew,

On Tue, Sep 07, 2010 at 03:38:13PM -0700, Andrew Morton wrote:
> > I noticed no throughput drop neither with PIO transfers nor
> > with DMA (tested on MPC8569E CPU), while latencies should be
> > greatly improved.
> 
> This patchset isn't causing any problems yet, but may do so in the
> future and will impact the validity of any testing.  It seems to be
> kind of stuck.  Should I drop it all?

I suggest keeping it -- I'll find time to test it out here soon, and
will keep it in mind as a possible regression cause.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
