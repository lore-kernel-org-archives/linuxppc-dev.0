Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 67880DDE2D
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 09:32:21 +1100 (EST)
In-Reply-To: <20070130160920.5e25d8ad.kim.phillips@freescale.com>
References: <20070130160920.5e25d8ad.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5964EC4C-0222-46DE-81C0-D85E0E0F08F0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add the mpc832xemds defconfig
Date: Tue, 30 Jan 2007 16:32:12 -0600
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 30, 2007, at 4:09 PM, Kim Phillips wrote:

> the defconfig for the 8323EMDS is identical to the 8360 defconfig,
> except CONFIG_MATH_EMULATION is set.
>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
>  arch/powerpc/configs/mpc832xemds_defconfig | 1083 +++++++++++++++++ 
> +++++++++++
>  1 files changed, 1083 insertions(+), 0 deletions(-)

applied.

- k
