Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E3893DDE08
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 08:12:22 +1100 (EST)
Message-Id: <3C82D21D-6BA0-49C1-A809-D18195FDC0BD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Barkowski <michael.barkowski@freescale.com>
In-Reply-To: <491C4544.7020707@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] mpc832x_rdb: fix swapped ethernet ids
Date: Wed, 19 Nov 2008 15:10:13 -0600
References: <491C4544.7020707@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 13, 2008, at 9:18 AM, Michael Barkowski wrote:

> ethernet0 (called FSL UEC0 in U-Boot) should be enet1 (UCC3/eth1), and
> ethernet1 should be enet0 (UCC2/eth0), to be consistent with U-Boot so
> that the interfaces do not swap addresses when control passes from
> U-Boot to the kernel.
>
> Signed-off-by: Michael Barkowski <michael.barkowski@freescale.com>
> Acked-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> Cheat sheet:
> | *Nickname* | WAN port | LAN switch |
> | *MAC address* | ethaddr | eth1addr |
> | *U-Boot name* | FSL UEC0 | FSL UEC1 |
> | *Linux name* | eth1 | eth0 |
> | *Phy ID* | 4 | 0 |
> | *QE Device* | UCC3@2200 | UCC2@3000 |
>
> arch/powerpc/boot/dts/mpc832x_rdb.dts |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)

applied to merge.

- k
