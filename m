Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id C38BBDDEC5
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 08:22:00 +1100 (EST)
Date: Fri, 21 Dec 2007 15:28:36 -0600
From: Olof Johansson <olof@lixom.net>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/3] [POWERPC] FSL UPM: routines to manage FSL UPMs
Message-ID: <20071221212836.GB11910@lixom.net>
References: <20071221203552.GA4738@localhost.localdomain>
	<20071221203925.GA4829@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071221203925.GA4829@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 21, 2007 at 11:39:25PM +0300, Anton Vorontsov wrote:
> Here are few routines needed to manage FSL UPMs. It doesn't include
> UPM programming, yet. So far u-boot manages to program everything.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  arch/powerpc/Kconfig          |    3 +
>  arch/powerpc/sysdev/Makefile  |    1 +
>  arch/powerpc/sysdev/fsl_upm.c |   65 +++++++++++++++++++++++++++++
>  include/asm-powerpc/fsl_upm.h |   90 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 159 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/sysdev/fsl_upm.c
>  create mode 100644 include/asm-powerpc/fsl_upm.h
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index a4fa173..aab8106 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -463,6 +463,9 @@ config FSL_PCI
>   	bool
>  	select PPC_INDIRECT_PCI
>  
> +config FSL_UPM
> +	bool

Please describe new config options, even if they're silent ones.


-Olof
