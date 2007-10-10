Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C21CBDDFEE
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 06:29:40 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9AKTbW0017407
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 16:29:37 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9AKTbhp472636
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 14:29:37 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9AKTaAm010689
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 14:29:36 -0600
Subject: Re: [PATCH 2/3] Remove empty ppc_md.setup_arch hooks.
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20071010184823.13609.41058.stgit@trillian.cg.shawcable.net>
References: <20071010184542.13609.70984.stgit@trillian.cg.shawcable.net>
	<20071010184823.13609.41058.stgit@trillian.cg.shawcable.net>
Content-Type: text/plain
Date: Wed, 10 Oct 2007 15:28:41 -0500
Message-Id: <1192048121.5534.86.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-10-10 at 12:48 -0600, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>

Assuming Paul likes the overall change, the 4xx parts look fine to me.

> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

> ---
> 
>  arch/powerpc/platforms/40x/virtex.c  |    5 -----
>  arch/powerpc/platforms/40x/walnut.c  |    5 -----
>  arch/powerpc/platforms/44x/bamboo.c  |    5 -----
>  arch/powerpc/platforms/44x/ebony.c   |    5 -----
>  arch/powerpc/platforms/44x/sequoia.c |    5 -----
>  5 files changed, 0 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/40x/virtex.c b/arch/powerpc/platforms/40x/virtex.c
> index b52aa94..14bbc32 100644
> --- a/arch/powerpc/platforms/40x/virtex.c
> +++ b/arch/powerpc/platforms/40x/virtex.c
> @@ -36,14 +36,9 @@ static int __init virtex_probe(void)
>  	return 1;
>  }
> 
> -static void __init virtex_setup_arch(void)
> -{
> -}
> -
>  define_machine(virtex) {
>  	.name			= "Xilinx Virtex",
>  	.probe			= virtex_probe,
> -	.setup_arch		= virtex_setup_arch,
>  	.init_IRQ		= xilinx_intc_init_tree,
>  	.get_irq		= xilinx_intc_get_irq,
>  	.calibrate_decr		= generic_calibrate_decr,
> diff --git a/arch/powerpc/platforms/40x/walnut.c b/arch/powerpc/platforms/40x/walnut.c
> index c17fdf2..eb0c136 100644
> --- a/arch/powerpc/platforms/40x/walnut.c
> +++ b/arch/powerpc/platforms/40x/walnut.c
> @@ -53,14 +53,9 @@ static int __init walnut_probe(void)
>  	return 1;
>  }
> 
> -static void __init walnut_setup_arch(void)
> -{
> -}
> -
>  define_machine(walnut) {
>  	.name			= "Walnut",
>  	.probe			= walnut_probe,
> -	.setup_arch		= walnut_setup_arch,
>  	.progress		= udbg_progress,
>  	.init_IRQ		= uic_init_tree,
>  	.get_irq		= uic_get_irq,
> diff --git a/arch/powerpc/platforms/44x/bamboo.c b/arch/powerpc/platforms/44x/bamboo.c
> index 9bc45de..470e1a3 100644
> --- a/arch/powerpc/platforms/44x/bamboo.c
> +++ b/arch/powerpc/platforms/44x/bamboo.c
> @@ -50,14 +50,9 @@ static int __init bamboo_probe(void)
>  	return 1;
>  }
> 
> -static void __init bamboo_setup_arch(void)
> -{
> -}
> -
>  define_machine(bamboo) {
>  	.name 				= "Bamboo",
>  	.probe 				= bamboo_probe,
> -	.setup_arch 		= bamboo_setup_arch,
>  	.progress 			= udbg_progress,
>  	.init_IRQ 			= uic_init_tree,
>  	.get_irq 			= uic_get_irq,
> diff --git a/arch/powerpc/platforms/44x/ebony.c b/arch/powerpc/platforms/44x/ebony.c
> index 5a7fec8..40e18fc 100644
> --- a/arch/powerpc/platforms/44x/ebony.c
> +++ b/arch/powerpc/platforms/44x/ebony.c
> @@ -57,14 +57,9 @@ static int __init ebony_probe(void)
>  	return 1;
>  }
> 
> -static void __init ebony_setup_arch(void)
> -{
> -}
> -
>  define_machine(ebony) {
>  	.name			= "Ebony",
>  	.probe			= ebony_probe,
> -	.setup_arch		= ebony_setup_arch,
>  	.progress		= udbg_progress,
>  	.init_IRQ		= uic_init_tree,
>  	.get_irq		= uic_get_irq,
> diff --git a/arch/powerpc/platforms/44x/sequoia.c b/arch/powerpc/platforms/44x/sequoia.c
> index 7d0d9d5..30700b3 100644
> --- a/arch/powerpc/platforms/44x/sequoia.c
> +++ b/arch/powerpc/platforms/44x/sequoia.c
> @@ -50,14 +50,9 @@ static int __init sequoia_probe(void)
>  	return 1;
>  }
> 
> -static void __init sequoia_setup_arch(void)
> -{
> -}
> -
>  define_machine(sequoia) {
>  	.name 				= "Sequoia",
>  	.probe 				= sequoia_probe,
> -	.setup_arch			= sequoia_setup_arch,
>  	.progress 			= udbg_progress,
>  	.init_IRQ 			= uic_init_tree,
>  	.get_irq 			= uic_get_irq,
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
