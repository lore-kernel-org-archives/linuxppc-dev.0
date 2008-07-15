Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1E063DE5C5
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 02:16:24 +1000 (EST)
Message-Id: <899616AF-593D-4B7A-A64E-3F15934CE6CF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080606192443.GA20132@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 1/2] [POWERPC] 86xx: suspend support
Date: Tue, 15 Jul 2008 11:16:14 -0500
References: <20080606192443.GA20132@polina.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>, Jason Jin <Jason.jin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 6, 2008, at 2:24 PM, Anton Vorontsov wrote:

> This patch adds suspend (standby, not suspend-to-ram) support for  
> MPC86xx
> processors.
>
> In standby mode MPC86xx is able to wakeup only upon external  
> interrupts
> (including sreset).
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Jason Jin <Jason.jin@freescale.com>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/Kconfig                          |    2 +-
> arch/powerpc/platforms/86xx/Makefile          |    1 +
> arch/powerpc/platforms/86xx/mpc86xx_suspend.c |   92 ++++++++++++++++ 
> +++++++++
> 3 files changed, 94 insertions(+), 1 deletions(-)
> create mode 100644 arch/powerpc/platforms/86xx/mpc86xx_suspend.c

I'd like to understand how much PM support these patches really add w/ 
regards to the work Scott's done for 83xx PM.

- k
