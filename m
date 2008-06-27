Return-Path: <dgibson@ozlabs.org>
Date: Fri, 27 Jun 2008 11:42:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: John Rigby <jrigby@freescale.com>
Subject: Re: [Resend][PATCH 1/8][Version 2] MPC5121 Update MPC5121ADS
	device tree
Message-ID: <20080627014233.GB17621@yookeroo.seuss>
References: <20080625203051.4FE882F123B@rumpole.eng.lineo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080625203051.4FE882F123B@rumpole.eng.lineo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 18, 2008 at 02:24:46PM -0600, John Rigby wrote:
> Updated device tree for MPC5121ADS

[snip]
>  	soc@80000000 {
>  		compatible = "fsl,mpc5121-immr";
> +		device_type = "soc";

I realise we still need the unwanted device_type value on the soc in
some cases for backwards compatibility, but why are you adding it
where it wasn't before..?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
