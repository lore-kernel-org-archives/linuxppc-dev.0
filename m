Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C5D6EDDE17
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Feb 2009 03:39:31 +1100 (EST)
Message-Id: <F910B89A-8CFE-4C46-A676-DCC5DAD55510@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090205201032.GA3425@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 1/2] powerpc/83xx: Fix missing #{address,
	size}-cells in mpc8313erdb.dts
Date: Fri, 6 Feb 2009 10:39:20 -0600
References: <20090205201032.GA3425@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 5, 2009, at 2:10 PM, Anton Vorontsov wrote:

> commit b31a1d8b41513b96e9c7ec2f68c5734cef0b26a4 ("gianfar: Convert
> gianfar to an of_platform_driver") introduced a child node for
> the ethernet@25000 controller, but no address and size cells
> specifiers were added, and that makes dtc unhappy:
>
> DTC: dts->dtb  on file "arch/powerpc/boot/dts/mpc8313erdb.dts"
> Warning (reg_format): "reg" property in /soc8313@e0000000/ 
> ethernet@25000/mdio@25520 has invalid length (8 bytes) (#address- 
> cells == 2, #size-cells == 1)
> Warning (avoid_default_addr_size): Relying on default #address-cells  
> value for /soc8313@e0000000/ethernet@25000/mdio@25520
> Warning (avoid_default_addr_size): Relying on default #size-cells  
> value for /soc8313@e0000000/ethernet@25000/mdio@25520
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8313erdb.dts |    2 ++
> 1 files changed, 2 insertions(+), 0 deletions(-)

applied to merge

- k
