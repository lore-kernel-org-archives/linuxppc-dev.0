Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2DDD3DE054
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 17:20:29 +1100 (EST)
In-Reply-To: <11691560171514-git-send-email-timur@freescale.com>
References: <11691560171514-git-send-email-timur@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <309FC1DE-9724-4172-BB13-D301D4A783F8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add support for the MPC8349E-mITX-GP
Date: Fri, 26 Jan 2007 00:19:26 -0600
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 18, 2007, at 3:33 PM, Timur Tabi wrote:

> Adds support for the MPC8349E-mITX-GP, which is a stripped-down  
> version
> of the MPC8349E-mITX reference board from Freescale.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc8349emitx-gp.dts     |  190 ++++
>  arch/powerpc/configs/mpc834x_itx_gp_defconfig | 1422 ++++++++++++++ 
> +++++++++++
>  2 files changed, 1612 insertions(+), 0 deletions(-)

Why does the defconfig differ so much from the mpc834x_itx_defconfig?

I understand not having ATA/SATA, disk support.  But I'd expect USB  
and that whatever debug settings would match between these two boards.

- k
