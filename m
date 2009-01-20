Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 01020DDF33
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 02:47:41 +1100 (EST)
Message-Id: <A46D6194-F7A2-4B6A-9ED9-23C642B87209@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20090120151613.GA2379@yoda.jdub.homelinux.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: Remove arch/ppc cruft from Kconfig
Date: Tue, 20 Jan 2009 09:47:33 -0600
References: <20090120151613.GA2379@yoda.jdub.homelinux.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 20, 2009, at 9:16 AM, Josh Boyer wrote:

> Remove some leftover cruft from the arch/ppc days
>
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
>
> ---
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index e39b73b..74cc312 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -876,10 +876,6 @@ source "drivers/Kconfig"
>
> source "fs/Kconfig"
>
> -# XXX source "arch/ppc/8xx_io/Kconfig"
> -
> -# XXX source "arch/ppc/8260_io/Kconfig"
> -
> source "arch/powerpc/sysdev/qe_lib/Kconfig"
>
> source "lib/Kconfig"

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
