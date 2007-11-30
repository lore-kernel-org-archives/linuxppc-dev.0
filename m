Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5115EDDD0A
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 11:33:54 +1100 (EST)
Message-Id: <DB394B79-DDF2-495A-9C99-F8B376FACA58@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jon Loeliger <jdl@jdl.com>
In-Reply-To: <E1IpStN-0003li-2G@jdl.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH Rev 2] 8xxx: Convert #include of asm/of_{platform,
	device}.h into linux/of_{platform, device}.h.
Date: Thu, 29 Nov 2007 18:33:43 -0600
References: <E1IpStN-0003li-2G@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 6, 2007, at 12:11 PM, Jon Loeliger wrote:

> From: Jon Loeliger <jdl@freescale.com>
>
> Signed-off-by: Jon Loeliger <jdl@freescale.com>
> Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>
> Chip away at some janitor work.
> Catch both asm/of_platform.h and asm/of_device.h this time.
> Add sfr's ACK.
>
> arch/powerpc/platforms/82xx/pq2fads.c     |    2 +-
> arch/powerpc/platforms/83xx/mpc832x_mds.c |    4 ++--
> arch/powerpc/platforms/83xx/mpc832x_rdb.c |    2 +-
> arch/powerpc/platforms/83xx/mpc836x_mds.c |    4 ++--
> arch/powerpc/platforms/85xx/mpc85xx_mds.c |    4 ++--
> 5 files changed, 8 insertions(+), 8 deletions(-)
>

applied.

- k
