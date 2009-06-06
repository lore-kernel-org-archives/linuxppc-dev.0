Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 24A76B70AB
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Jun 2009 10:28:50 +1000 (EST)
Subject: Re: Add "mpc5200-simple-platform" to the list of supported boards
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marcelo Dalmas <m_dalmas@yahoo.com.br>
In-Reply-To: <461095.11075.qm@web111310.mail.gq1.yahoo.com>
References: <461095.11075.qm@web111310.mail.gq1.yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 06 Jun 2009 10:28:44 +1000
Message-Id: <1244248124.31984.27.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-06-05 at 16:20 -0700, Marcelo Dalmas wrote:
> Hello,
> 
> Adding  "mpc5200-simple-platform" to the list of supported boards allow to use the option "Generic support for simple MPC5200 based boards" without patching the kernel. Just set model to "mpc5200-simple-plataform" on your dts file.

I'm generally against that. Some time you'll need to diverge and poof !
you lost the ability to identify your board... it's also a very linux
centric thing to put in the device-tree.

Cheers,
Ben.

> diff --git a/arch/powerpc/platforms/52xx/mpc5200_simple.c b/arch/powerpc/platforms/52xx/mpc5200_simple.c
> index c31e5b5..a2df795 100644
> --- a/arch/powerpc/platforms/52xx/mpc5200_simple.c
> +++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c
> @@ -50,6 +50,7 @@ static void __init mpc5200_simple_setup_arch(void)
>  
>  /* list of the supported boards */
>  static char *board[] __initdata = {
> +	"mpc5200-simple-platform",
>  	"intercontrol,digsy-mtc",
>  	"phytec,pcm030",
>  	"phytec,pcm032",
> 
> 
> 
> 
>       Veja quais são os assuntos do momento no Yahoo! +Buscados
> http://br.maisbuscados.yahoo.com
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
