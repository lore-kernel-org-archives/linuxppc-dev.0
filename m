Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 964E7DDDF3
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 16:37:35 +1100 (EST)
Message-Id: <EE043CEE-237B-411E-B11C-3F42F697CED1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
In-Reply-To: <20080131125658.c40b830f.kim.phillips@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] powerpc: correct 2nd pci controller interrupt value in
	mpc834x_mds dts
Date: Tue, 5 Feb 2008 23:37:22 -0600
References: <20080131125658.c40b830f.kim.phillips@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, peter.vanackeren@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 31, 2008, at 12:56 PM, Kim Phillips wrote:

> according to the 8349EA ref man, pci2 IRQ is 67.  Thanks to Peter
> Van Ackeren for finding this.
>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> arch/powerpc/boot/dts/mpc834x_mds.dts |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied.

- k
