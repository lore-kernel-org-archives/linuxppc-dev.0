Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6EC3ADDFFB
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 11:46:08 +1100 (EST)
Date: Fri, 25 Jan 2008 15:20:20 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 2/5] [POWERPC][NET] ucc_geth_mii and users: get rid of
	device_type
In-Reply-To: <20080124154001.GB23246@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0801251519500.20972@blarg.am.freescale.net>
References: <20080124151850.GA15190@localhost.localdomain>
	<20080124154001.GB23246@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jeff@garzik.org>,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 24 Jan 2008, Anton Vorontsov wrote:

> device_type property is bogus, thus use proper compatible.
>
> Also change compatible property to "fsl,ucc-mdio".
>
> Per http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048388.html
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  arch/powerpc/boot/dts/mpc832x_mds.dts |    3 +--
>  arch/powerpc/boot/dts/mpc832x_rdb.dts |    3 +--
>  arch/powerpc/boot/dts/mpc836x_mds.dts |    3 +--
>  arch/powerpc/boot/dts/mpc836x_rdk.dts |    3 +--
>  arch/powerpc/boot/dts/mpc8568mds.dts  |    2 +-
>  drivers/net/ucc_geth_mii.c            |    3 +++
>  6 files changed, 8 insertions(+), 9 deletions(-)
>

applied. (same comment about rdk)

- k
