Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 27D7E1007D8
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Oct 2010 06:28:23 +1100 (EST)
Subject: Re: [PATCH 01/11] powerpc/mpc8xxx_gpio: Add support for 'qoriq-gpio'
	controllers
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1286564813-21209-1-git-send-email-galak@kernel.crashing.org>
Date: Fri, 8 Oct 2010 14:24:41 -0500
Message-Id: <565ACB74-BFF4-4801-BFE4-24E0BD870707@kernel.crashing.org>
References: <1286564813-21209-1-git-send-email-galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 8, 2010, at 2:06 PM, Kumar Gala wrote:

> Add 'fsl,qoriq-gpio' compatiable to the list we search for to bind
> against for mpc8xxx_gpio.  This compatiable will be used on P1-P5xxx
> QorIQ devices like P4080.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/sysdev/mpc8xxx_gpio.c |    3 +++
> 1 files changed, 3 insertions(+), 0 deletions(-)

applied to next

- k
