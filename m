Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AC57AB7450
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 21:30:29 +1000 (EST)
Subject: Re: [PATCH] ppc/85xx: specify interrupt for pq3-localbus devices
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1306941318-5771-1-git-send-email-dbaryshkov@gmail.com>
Date: Wed, 22 Jun 2011 06:30:16 -0500
Message-Id: <07159B8F-2EC4-43EE-95DF-74BB8B2D457D@kernel.crashing.org>
References: <1306941318-5771-1-git-send-email-dbaryshkov@gmail.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 1, 2011, at 10:15 AM, Dmitry Eremin-Solenikov wrote:

> fsl-lbc driver requires an interrupt to bind to localbus device.
> Populate 85xx boards' dts trees with lbc interrupt info.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
> arch/powerpc/boot/dts/mpc8568mds.dts       |    2 ++
> arch/powerpc/boot/dts/socrates.dts         |    2 ++
> arch/powerpc/boot/dts/tqm8540.dts          |    2 ++
> arch/powerpc/boot/dts/tqm8548-bigflash.dts |    2 ++
> arch/powerpc/boot/dts/tqm8548.dts          |    2 ++
> arch/powerpc/boot/dts/tqm8560.dts          |    2 ++
> arch/powerpc/boot/dts/xpedite5200.dts      |    2 ++
> arch/powerpc/boot/dts/xpedite5200_xmon.dts |    2 ++
> 8 files changed, 16 insertions(+), 0 deletions(-)

applied to next

- k
