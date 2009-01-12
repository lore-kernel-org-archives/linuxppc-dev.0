Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 59E6DDE410
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 02:10:29 +1100 (EST)
Message-Id: <8F6FC95A-68E3-40FF-B1A9-F3D7BF1AD417@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090111153013.GA31791@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc/83xx: Make serial ports work on MPC8315E-RDB w/
	FSL U-Boots
Date: Mon, 12 Jan 2009 09:10:17 -0600
References: <20090111153013.GA31791@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 11, 2009, at 9:30 AM, Anton Vorontsov wrote:

> FSL U-Boots use /soc8315@e0000000 node to search and fixup serial
> nodes' clock-frequency properties. Though in upstream kernels we use
> new naming convention -- for IMMR address space dts files specify
> /immr@e0000000 nodes.
>
> This makes FSL U-Boots fail to fixup the clock frequencies, and that
> leads to serial ports misbehaviour. We can workaround the issue by
> filling the clock frequency values manually.
>
> p.s. For the same reason FSL U-Boots fail to fixup MAC addresses for
> ethernet nodes, so users should either change the .dts file locally
> or set MAC address via `ifconfig hw ether' command.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>
> Leon,
>
> With this patch 2.6.28 kernel boots and works fine with the U-Boot
> I took from this image (downloadable from freescale.com):
>
> $ md5sum MPC8315ERDB_20080321-ltib.iso
> 009730826366d593347b88fa4fdb9be0  MPC8315ERDB_20080321-ltib.iso
>
> That is, U-Boot 1.3.0-rc2 (Mar 21 2008 - 13:36:09) MPC83XX
>
> arch/powerpc/boot/dts/mpc8315erdb.dts |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)

applied

- k
