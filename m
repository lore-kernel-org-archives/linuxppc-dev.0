Return-Path: <ben@trinity.fluff.org>
Received: from trinity.fluff.org (trinity.fluff.org [89.16.178.74])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5884EB7014
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2011 03:40:06 +1100 (EST)
Date: Tue, 15 Mar 2011 16:12:01 +0000
From: Ben Dooks <ben@trinity.fluff.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] i2c-mpc: Add support for 64bit system
Message-ID: <20110315161201.GJ17460@trinity.fluff.org>
References: <1300204963-15855-1-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300204963-15855-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org, ben-linux@fluff.org,
	B33228@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 15, 2011 at 11:02:43AM -0500, Kumar Gala wrote:
> Currently i2c-mpc supports 32bit system only, this modification makes it
> supported on both 32-bit and 64-bit systems.  The P5020 is the first
> 64-bit PPC system with the i2c-mpc controller.
> 
> Based in patch from Xulei <B33228@freescale.com>
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

ok, will add to -next

> ---
>  drivers/i2c/busses/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 113505a..107d5c2 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -433,7 +433,7 @@ config I2C_IXP2000
>  
>  config I2C_MPC
>  	tristate "MPC107/824x/85xx/512x/52xx/83xx/86xx"
> -	depends on PPC32
> +	depends on PPC
>  	help
>  	  If you say yes to this option, support will be included for the
>  	  built-in I2C interface on the MPC107, Tsi107, MPC512x, MPC52xx,
> -- 
> 1.7.2.3
> 

-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
