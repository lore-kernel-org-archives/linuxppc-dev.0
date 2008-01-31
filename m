Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AEA9DDDDEF
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 15:31:02 +1100 (EST)
Message-Id: <B7091304-8304-4C9A-8190-4889DDB3744E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
In-Reply-To: <20080130124619.32484395.kim.phillips@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH v3] powerpc: configure USB clock for MPC8315E
Date: Wed, 30 Jan 2008 22:30:53 -0600
References: <20080130124619.32484395.kim.phillips@freescale.com>
Cc: olof@lixom.net, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Jerry Huang <Chang-Ming.Huang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 30, 2008, at 12:46 PM, Kim Phillips wrote:

> SCCR USB bits are in a different location on the mpc8315.
>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> changed to detect parent node compatibility with fsl,mpc8315-immr, and
> do a of_node_put when done.
>
> arch/powerpc/boot/dts/mpc8315erdb.dts |    2 +-
> arch/powerpc/platforms/83xx/mpc83xx.h |    2 ++
> arch/powerpc/platforms/83xx/usb.c     |   17 +++++++++++++----
> 3 files changed, 16 insertions(+), 5 deletions(-)

applied.

- k
