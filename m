Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6BEB7DDF36
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 23:19:32 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m63DJPkQ004213
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Jul 2008 09:19:25 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m63DI9a4232174
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Jul 2008 09:18:09 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m63DI83Z013023
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Jul 2008 09:18:08 -0400
Date: Thu, 3 Jul 2008 09:14:48 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: John Linn <john.linn@xilinx.com>
Subject: Re: [PATCH] powerpc: Xilinx: add 440 platform support
Message-ID: <20080703091448.4e298ce8@zod.rchland.ibm.com>
In-Reply-To: <20080701224829.EC51111E8013@mail35-sin.bigfish.com>
References: <20080701224829.EC51111E8013@mail35-sin.bigfish.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 1 Jul 2008 15:48:26 -0700
John Linn <john.linn@xilinx.com> wrote:

> Support for the Xilinx Virtex5 FXT 440 is being
> added.
> 
> Signed-off-by: John Linn <john.linn@xilinx.com>
> ---
>  arch/powerpc/platforms/44x/Kconfig  |   25 ++++++++++++++
>  arch/powerpc/platforms/44x/Makefile |    1 +
>  arch/powerpc/platforms/44x/virtex.c |   60 +++++++++++++++++++++++++++++++++++
>  3 files changed, 86 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/platforms/44x/virtex.c
> 
> diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
> index 6abe913..84eb847 100644
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -102,6 +102,22 @@ config YOSEMITE
>  #	help
>  #	  This option enables support for the IBM PPC440GX evaluation board.
> 
> +config XILINX_VIRTEX440_GENERIC_BOARD
> +	bool "Generic Xilinx Virtex 440 board"
> +	depends on 44x
> +	default n
> +	select XILINX_VIRTEX_5_FXT

If this is for generic Virtex 440 board support, why is it selecting a
specific Virtex 5 board?  Or am I confused as to what
XILINX_VIRTEX_5_FXT is?

josh
