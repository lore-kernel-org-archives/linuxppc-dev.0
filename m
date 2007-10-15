Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 25C73DE094
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 23:42:59 +1000 (EST)
In-Reply-To: <20071014044154.23438.58701.stgit@trillian.cg.shawcable.net>
References: <20071014044041.23438.14070.stgit@trillian.cg.shawcable.net>
	<20071014044154.23438.58701.stgit@trillian.cg.shawcable.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <751956FC-6B75-416C-A62A-67915652EA51@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 2/7] rheap: Changes config mechanism
Date: Mon, 15 Oct 2007 08:43:27 -0500
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, domen.puncer@telargo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 13, 2007, at 11:41 PM, Grant Likely wrote:

> From: Sylvain Munaut <tnt@246tNt.com>
>
> Instead of having in the makefile all the option that
> requires rheap, we define a configuration symbol
> and when needed we make sure it's selected.
>
> Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
>  arch/powerpc/Kconfig                   |    4 ++++
>  arch/powerpc/lib/Makefile              |    5 +----
>  arch/powerpc/platforms/Kconfig         |    2 ++
>  arch/powerpc/platforms/Kconfig.cputype |    1 +
>  arch/ppc/Kconfig                       |    6 ++++++
>  5 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 037664d..8300e6a 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -698,3 +698,7 @@ source "crypto/Kconfig"
>  config PPC_CLOCK
>  	bool
>  	default n
> +
> +config PPC_LIB_RHEAP

we should really have help for this option.

> +	bool
> +

- k
