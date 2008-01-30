Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BE6B6DDE36
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 04:25:00 +1100 (EST)
Message-Id: <477C3DB8-5505-4AB0-A9C6-766DC4E698B4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
In-Reply-To: <20080130110857.c66f98fb.kim.phillips@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH v2] powerpc: configure USB clock for MPC8315E
Date: Wed, 30 Jan 2008 11:24:21 -0600
References: <20080130110857.c66f98fb.kim.phillips@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Jerry Huang <Chang-Ming.Huang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 30, 2008, at 11:08 AM, Kim Phillips wrote:

> SCCR USB bits are in a different location on the mpc8315.
>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> changed to match compatible on non-board specific "fsl,mpc8315-usb2- 
> dr".

Try again.  The SCCR isn't a function of the USB block.  Its more a  
function of the mpc8315 soc platform.

- k
