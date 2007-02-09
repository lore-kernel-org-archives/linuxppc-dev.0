Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2CD7DDDEFF
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 03:30:59 +1100 (EST)
In-Reply-To: <11710369101980-git-send-email-timur@freescale.com>
References: <11710369101980-git-send-email-timur@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <122999F4-9700-46C3-9FA5-0AD8FA17A832@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Updated mpc834x_itx_defconfig
Date: Fri, 9 Feb 2007 10:30:09 -0600
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


On Feb 9, 2007, at 10:01 AM, Timur Tabi wrote:

> This patch updates the defconfig for the MPC8349E-mITX.  In  
> addition to picking
> up changes from recent kernels, it turns off math emulation,  
> disables support
> for e100 (which doesn't ship with the system), turns off input  
> devices,
> turns on some I2C support, turns off HW monitoring (HW not yet  
> supported),
> turns off OHCI USB (not used), turns off USB gadget support (HW not  
> yet
> supported), turns on DOS FS support, and turns off kernel debugging.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>  arch/powerpc/configs/mpc834x_itx_defconfig |  232 ++++++ 
> +--------------------
>  1 files changed, 60 insertions(+), 172 deletions(-)

Should the same changes be made to the gp config?

- k
