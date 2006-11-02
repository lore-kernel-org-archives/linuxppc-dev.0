Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 9484B67BC4
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 01:58:41 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so124823ugf
	for <linuxppc-dev@ozlabs.org>; Thu, 02 Nov 2006 06:58:39 -0800 (PST)
Message-ID: <528646bc0611020658le3adc94p30f372f3a1a8b07e@mail.gmail.com>
Date: Thu, 2 Nov 2006 07:58:39 -0700
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

If you do this, then where should embedded 6xx board ports go?  For
example; mpc52xx for which there are currently patches on the mailing
list.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
