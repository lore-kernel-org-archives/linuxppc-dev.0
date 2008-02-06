Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 67FA2DDE09
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 16:38:46 +1100 (EST)
Message-Id: <E2EE4C8B-818A-462D-91C5-5B525F6FBEB2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jon Loeliger <jdl@jdl.com>
In-Reply-To: <E1JLNdb-0002G5-Cd@jdl.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] [POWERPC] Fix storcenter DTS typos, feedback, IRQs.
Date: Tue, 5 Feb 2008 23:38:35 -0600
References: <E1JLNdb-0002G5-Cd@jdl.com>
Cc: linuxppc-dev@ozlabs.org, andy@protium.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 2, 2008, at 1:02 PM, Jon Loeliger wrote:

>
> Cleaned up IRQ layout and removed unsused ISU allocations.
> Fixed RTC address typo from /dts-v1/ conversion.
> Incorporated list suggestions to use an "iomega," vendor prefix,
> and to use a node reference rather than a hard path.
>
> Signed-off-by: Jon Loeliger <jdl@@jdl.com>
> ---
>
> Kumar,
>
> I tried to use one large, linear IRQ block and shift the
> IRQs up to, like, around 129 or so, but it did not work.
> This patch definitely works, so I suspect some issue trying
> to setup (non-)IRQs between 0x50000 and 0x51000 or so.  Ick.

We can figure this out later.

> In any even, this is defintely a valid bug fix.  If you
> would, please pick up for 2.6.25.
>
> Thanks,
> jdl


applied.

- k
