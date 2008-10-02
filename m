Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 00031DDFE6
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Oct 2008 05:48:59 +1000 (EST)
Message-Id: <504AAC96-2F7E-4A06-B544-1F2169BB2176@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20081002151852.GA8823@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc/83xx: don't probe broken PCI on mpc837x_mds boards
Date: Thu, 2 Oct 2008 14:48:44 -0500
References: <20081002151852.GA8823@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 2, 2008, at 10:18 AM, Anton Vorontsov wrote:

> In the standalone setup the board's CPLD disables the PCI internal
> arbiter, thus any access to the PCI bus will hang the board.
>
> When there is no PCI arbiter on the bus the u-boot marks the PCI
> bus as broken and we should not try to probe it.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Can you add to the commit message something about using the 'status  
field in the device tree to determine if the pci controller is  
available'

- k
