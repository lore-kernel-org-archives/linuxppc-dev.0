Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7DA31B7B7F
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 04:20:52 +1000 (EST)
Subject: Re: [PATCH][v2] powerpc/85xx: Create dts for each core in CAMP mode
	for P2020RDB
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1253380436-1590-1-git-send-email-poonam.aggrwal@freescale.com>
Date: Thu, 24 Sep 2009 11:20:43 -0700
Message-Id: <85051629-88AD-4AF4-A2D8-93E3A2EB7343@kernel.crashing.org>
References: <1253380436-1590-1-git-send-email-poonam.aggrwal@freescale.com>
To: Poonam Aggrwal <poonam.aggrwal@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 19, 2009, at 10:13 AM, Poonam Aggrwal wrote:

> This patch creates the dts files for each core and splits the  
> devices between
> the two cores for P2020RDB.
>
> core0 has memory, L2, i2c, spi, dma1, usb, eth0, eth1, crypto,  
> global-util, pci0
> core1 has L2, dma2, eth0, pci1, msi.
>
> MPIC is shared between two cores but each core will protect its
> interrupts from other core by using "protected-sources" of mpic.
>
> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> ---
> - based on http://www.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
> - branch->next
> - Removed interrupt properties for serial ports to make them work in  
> polling mode.
> arch/powerpc/boot/dts/p2020rdb_camp_core0.dts |  363 ++++++++++++++++ 
> +++++++++
> arch/powerpc/boot/dts/p2020rdb_camp_core1.dts |  184 +++++++++++++
> arch/powerpc/platforms/85xx/mpc85xx_rdb.c     |   10 +-
> 3 files changed, 556 insertions(+), 1 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
> create mode 100644 arch/powerpc/boot/dts/p2020rdb_camp_core1.dts

applied to merge

- k
