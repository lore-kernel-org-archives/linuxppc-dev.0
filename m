Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1B601DE06F
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 01:44:35 +1000 (EST)
Date: Mon, 27 Aug 2007 10:44:26 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 85xx: Renamed mpc8544_ds.c to mpc85xx_ds.c
Message-ID: <20070827154426.GA10453@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.64.0708271025170.15438@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0708271025170.15438@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 27, 2007 at 10:25:53AM -0500, Kumar Gala wrote:
> diff --git a/arch/powerpc/platforms/85xx/mpc8544_ds.c b/arch/powerpc/platforms/85xx/mpc8544_ds.c
> deleted file mode 100644
> index 0f834d8..0000000
> --- a/arch/powerpc/platforms/85xx/mpc8544_ds.c
> +++ /dev/null
> @@ -1,186 +0,0 @@
> -/*
> - * MPC8544 DS Board Setup
> - *
[snip]
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> new file mode 100644
> index 0000000..0f834d8
> --- /dev/null
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> @@ -0,0 +1,186 @@
> +/*
> + * MPC8544 DS Board Setup
> + *

If you pass -M to git-format-patch, it'll detect renames rather than
showing a large delete followed by a large create.

-Scott
