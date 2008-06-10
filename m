Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C9E6EDDDF9
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 00:20:45 +1000 (EST)
Message-Id: <5DC51543-CD6E-411E-B141-EF34786854D3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080317175208.GA17844@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] [POWERPC] 83xx: MPC837xRDB's VSC7385 ethernet switch
	isn't on the MDIO bus
Date: Tue, 10 Jun 2008 09:20:39 -0500
References: <20080317175208.GA17844@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 17, 2008, at 12:52 PM, Anton Vorontsov wrote:

> MDIO-less PHYs should use CONFIG_FIXED_PHY driver and appropriate
> fixed-link property in the device tree.
>
> If not, ethernet will not work:
>  e0024520:03 not found
>  eth1: Could not attach to PHY
>  IP-Config: Failed to open eth1
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8377_rdb.dts      |    8 +-------
> arch/powerpc/boot/dts/mpc8378_rdb.dts      |    8 +-------
> arch/powerpc/boot/dts/mpc8379_rdb.dts      |    8 +-------
> arch/powerpc/configs/mpc837x_rdb_defconfig |    2 +-
> 4 files changed, 4 insertions(+), 22 deletions(-)

applied to for-2.6.26 branch.

- k
