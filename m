Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 41C8FDDF54
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Mar 2008 09:51:51 +1100 (EST)
Message-Id: <5F3A8414-A136-4C96-A419-1E0CCBDFABDC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jeremy McNicoll <jeremy.mcnicoll@windriver.com>
In-Reply-To: <1204920849-31741-1-git-send-email-jeremy.mcnicoll@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] sbc8548: fix incorrect PCI-X and PCI interrupt map
Date: Fri, 7 Mar 2008 16:51:46 -0600
References: <1204920849-31741-1-git-send-email-jeremy.mcnicoll@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 7, 2008, at 2:14 PM, Jeremy McNicoll wrote:

> The following patch allows interrupts to occur on the
> sbc8548. Currently PCI and PCI-X devices get assigned an IRQ
> but the interrupt count never increases.  This solves the
> problem and adds PCI support as well.
>
> Signed-off-by: Jeremy McNicoll <jeremy.mcnicoll@windriver.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> arch/powerpc/boot/dts/sbc8548.dts |   16 +++++++++++-----
> 1 files changed, 11 insertions(+), 5 deletions(-)

applied.

- k
