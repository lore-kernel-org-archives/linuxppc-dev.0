Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6802FB70B3
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Dec 2009 12:57:26 +1100 (EST)
Subject: Re: [PATCH 3/3] powerpc/83xx: Add power management support for
	MPC8315E-RDB boards
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20091210180103.GC32482@oksana.dev.rtsoft.ru>
Date: Thu, 10 Dec 2009 19:57:09 -0600
Message-Id: <91337944-E3B3-4ADA-BB29-C3231841C5EA@kernel.crashing.org>
References: <20091210175957.GA30682@oksana.dev.rtsoft.ru>
	<20091210180103.GC32482@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 10, 2009, at 12:01 PM, Anton Vorontsov wrote:

> - Add nodes for PMC and GTM controllers. GTM4 can be used as a wakeup
>  source;
> 
> - Add fsl,magic-packet properties to eTSEC nodes, i.e. wake-on-lan
>  support. Unlike MPC8313 processors, MPC8315 can resume from deep
>  sleep upon magic packet reception.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8315erdb.dts |   27 +++++++++++++++++++++++++++
> 1 files changed, 27 insertions(+), 0 deletions(-)

applied to next

- k
