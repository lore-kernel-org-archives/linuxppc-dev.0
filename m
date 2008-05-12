Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DF9F3DE168
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 01:39:44 +1000 (EST)
Message-Id: <86BDD6B6-A561-4A49-AAFE-9351CD1F2DD6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080504184627.GA16998@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH v2] [POWERPC] 86xx: mpc8610_hpcd: add support for NOR and
	NAND flashes
Date: Mon, 12 May 2008 10:39:40 -0500
References: <20080504150727.GA27038@polina.dev.rtsoft.ru>
	<20080504184627.GA16998@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 4, 2008, at 1:46 PM, Anton Vorontsov wrote:

> This patch adds device tree nodes for NOR and NAND flashes and places
> board-control node inside the localbus.
>
> defconfig and board file updated appropriately.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>
> Heh, this is v2. The flash setup on the MPC8610 tricked me.
>
> There is single NAND package, but with four physical NAND
> chips inside. Each occupy its own localbus CE line, i.e. bank.
>
> arch/powerpc/boot/dts/mpc8610_hpcd.dts      |   60 +++++++++++++++++-
> arch/powerpc/configs/mpc8610_hpcd_defconfig |   88 ++++++++++++++++++ 
> ++++++++-
> arch/powerpc/platforms/86xx/mpc8610_hpcd.c  |    1 +
> 3 files changed, 145 insertions(+), 4 deletions(-)

applied.

- k
