Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E0D6CB83F0
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 01:11:47 +1100 (EST)
Subject: Re: [PATCH 6/7] powerpc/86xx: Add power management support for
	MPC8610HPCD boards
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20090915214400.GF24821@oksana.dev.rtsoft.ru>
Date: Thu, 5 Nov 2009 08:11:42 -0600
Message-Id: <C00B8679-9C14-45D3-82CF-4BDA53586333@kernel.crashing.org>
References: <20090915214321.GA19377@oksana.dev.rtsoft.ru>
	<20090915214400.GF24821@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 15, 2009, at 4:44 PM, Anton Vorontsov wrote:

> This patch adds needed nodes and properties to support suspend/resume
> on the MPC8610HPCD boards.
>
> There is a dedicated switch (SW9) that is used to wake up the boards.
> By default the SW9 button is routed to IRQ8, but could be re-routed
> (via PIXIS) to sreset.
>
> With 'no_console_suspend' kernel command line argument specified, the
> board is also able to wakeup upon serial port input.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Acked-by: Scott Wood <scottwood@freescale.com> [dts]
> ---
> Documentation/powerpc/dts-bindings/fsl/board.txt |    4 ++
> arch/powerpc/boot/dts/mpc8610_hpcd.dts           |   26 ++++++++++++
> arch/powerpc/platforms/86xx/mpc8610_hpcd.c       |   48 +++++++++++++ 
> +++++++--
> 3 files changed, 74 insertions(+), 4 deletions(-)

applied to next

- k
