Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 4EA8067C3F
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 02:13:17 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1302501ugf
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 07:13:16 -0800 (PST)
Message-ID: <528646bc0611210713t4e9a9f6eo9e89658ae91a7f98@mail.gmail.com>
Date: Tue, 21 Nov 2006 08:13:16 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [patch 08/16] powerpc: remove EMBEDDED6xx Kconfig entry
In-Reply-To: <20061102125627.149261000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20061102125555.252338000@localhost.localdomain>
	<20061102125627.149261000@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/2/06, s.hauer@pengutronix.de <s.hauer@pengutronix.de> wrote:
> remove EMBEDDED6xx Kconfig entry
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

FWIW, I'm going to say ACK on this one.  Since this discussion, I've
moved my lite5200 support out of platforms/embedded6xx and changed it
to use CONFIG_PPC_MULTIPLATFORM

Cheers,
g.


>
> Index: linux-2.6/arch/powerpc/Kconfig
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/Kconfig
> +++ linux-2.6/arch/powerpc/Kconfig
> @@ -338,10 +338,6 @@ config PPC_MULTIPLATFORM
>           RS/6000 machine, an Apple machine, or a PReP, CHRP,
>           Maple or Cell-based machine.
>
> -config EMBEDDED6xx
> -       bool "Embedded 6xx/7xx/7xxx-based board"
> -       depends on PPC32 && (BROKEN||BROKEN_ON_SMP)
> -
>  config APUS
>         bool "Amiga-APUS"
>         depends on PPC32 && BROKEN
>
> --
>  Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
>   Pengutronix - Linux Solutions for Science and Industry
>     Handelsregister: Amtsgericht Hildesheim, HRA 2686
>       Hannoversche Str. 2, 31134 Hildesheim, Germany
>     Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
