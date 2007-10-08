Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 02BE2DDFC4
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 05:29:09 +1000 (EST)
Date: Mon, 8 Oct 2007 14:34:04 -0500
From: Olof Johansson <olof@lixom.net>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 2/3] [POWERPC] Add AMCC Kilauea eval board support to
	platforms/40x
Message-ID: <20071008193404.GA10348@lixom.net>
References: <200710081108.51625.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200710081108.51625.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Mon, Oct 08, 2007 at 11:08:51AM +0200, Stefan Roese wrote:
> This patch adds basic support for the new 405EX and the AMCC eval board
> Kilauea to arch/powerpc.

[...]

> +config KILAUEA
> +	bool "Kilauea"
> +	depends on 40x
> +	default y
> +	select 405EX
> +	help
> +	  This option enables support for the AMCC PPC405EX evaluation board.
> +
>  #config REDWOOD_5
>  #	bool "Redwood-5"
>  #	depends on 40x
> @@ -89,14 +97,17 @@ config 403GCX
>  	#depends on OAK
>  	select IBM405_ERR51
>  
> +config 405EP
> +	bool
> +
> +config 405EX
> +	bool
> +

Do you really need config options for 405EP/EX? I don't seem them used anywhere
else in the code (and it's also contradictory to the whole new multiplatform way
of looking at stuff :).

I know the 405/440 is still somewhat #ifdef:ed on the cpu here and there, but since
this doesn't add any such code I don't see a need for the config options?


-Olof
