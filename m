Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A725ADDE09
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 03:07:01 +1100 (EST)
Message-Id: <83FEE161-D10D-4E21-BDB3-D0B6D49668CE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jochen Friedrich <jochen@scram.de>
In-Reply-To: <479764B8.4010909@scram.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCHv2 5/8] [POWERPC] Remove sysdev/commproc.h
Date: Wed, 23 Jan 2008 10:06:44 -0600
References: <479764B8.4010909@scram.de>
Cc: Scott Wood <scottwood@freescale.com>, "Kernel,
	Linux" <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 23, 2008, at 10:00 AM, Jochen Friedrich wrote:

> Move cpm1 specific prototypes to asm/commproc.h and mpc8xx specific
> prototypes to asm/mpc8xx.h. Adjust includes accordingly. Remove now
> unneeded sysdev/commproc.h.
>
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> ---
> arch/powerpc/platforms/8xx/ep88xc.c          |    3 +--
> arch/powerpc/platforms/8xx/m8xx_setup.c      |    1 -
> arch/powerpc/platforms/8xx/mpc86xads_setup.c |    2 --
> arch/powerpc/platforms/8xx/mpc885ads_setup.c |    2 --
> arch/powerpc/sysdev/commproc.c               |    1 -
> arch/powerpc/sysdev/commproc.h               |   12 ------------
> arch/powerpc/sysdev/mpc8xx_pic.c             |    1 -
> drivers/net/fs_enet/mac-scc.c                |    1 -
> include/asm-powerpc/commproc.h               |    2 ++
> include/asm-powerpc/mpc8xx.h                 |    7 +++++++

Do we really need the prototypes you moved into asm/mpc8xx.h here?   
can they just live in platforms/8xx/8xx.h or something like that?

- k
