Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id E340CDDE03
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jan 2008 11:48:33 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2052740wag.13
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 16:48:32 -0800 (PST)
Message-ID: <9e4733910801261648v55ca0015v606ce80a05738a2@mail.gmail.com>
Date: Sat, 26 Jan 2008 19:48:32 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: Patches added to for-2.6.25/master branches of powerpc.git
In-Reply-To: <fa686aa40801261509o2f6fd195h2f2662e67c022ec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <18330.53318.857148.409675@cargo.ozlabs.ibm.com>
	<fa686aa40801261509o2f6fd195h2f2662e67c022ec@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/26/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> Grant Likely (6):
>       [POWERPC] mpc52xx: clean up Kconfig
>       [POWERPC] mpc5200: normalize compatible property bindings
>       [POWERPC] mpc5200: make dts files conform to generic names
> recommended practice
>       [POWERPC] Efika: prune fixups and make them more carefull
>       [POWERPC] Add common clock setting routine mpc52xx_psc_set_clkdiv()
>       [POWERPC] mpc52xx_psc_spi device driver must not touch port_config and cdm

Does this fix these warnings...

  CC      drivers/spi/mpc52xx_psc_spi.o
drivers/spi/mpc52xx_psc_spi.c: In function 'mpc52xx_psc_spi_activate_cs':
drivers/spi/mpc52xx_psc_spi.c:110: warning: passing argument 1 of
'in_be16' from incompatible pointer type
drivers/spi/mpc52xx_psc_spi.c:116: warning: passing argument 1 of
'out_be16' from incompatible pointer type
drivers/spi/mpc52xx_psc_spi.c: In function 'mpc52xx_psc_spi_port_config':
drivers/spi/mpc52xx_psc_spi.c:417: warning: passing argument 1 of
'out_be16' from incompatible pointer type




-- 
Jon Smirl
jonsmirl@gmail.com
