Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 9EC9ADDF31
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 15:27:56 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so70974anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 22:27:55 -0700 (PDT)
Message-ID: <fa686aa40807302227r7ef32bbpc8e517d5fe1d42ab@mail.gmail.com>
Date: Wed, 30 Jul 2008 23:27:55 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 4/8] Silence warnings in
	arch/powerpc/platforms/52xx/mpc52xx_pci.c
In-Reply-To: <9e4733910807302108q689c9c82yb010c75cba770218@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <cac86e24e42bd05087b43663b687f04df91326ba.1217476198.git.tony@bakeyournoodle.com>
	<96343fe00bd43a12b1739ff1513ba07224e3f302.1217476198.git.tony@bakeyournoodle.com>
	<9e4733910807302108q689c9c82yb010c75cba770218@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 30, 2008 at 10:08 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> There are some warnings in mpc5200 spi that I haven't looked at....
>
> drivers/spi/mpc52xx_psc_spi.c: In function 'mpc52xx_psc_spi_activate_cs':
> drivers/spi/mpc52xx_psc_spi.c:111: warning: passing argument 1 of
> 'in_be16' from incompatible pointer type
> drivers/spi/mpc52xx_psc_spi.c:117: warning: passing argument 1 of
> 'out_be16' from incompatible pointer type
> drivers/spi/mpc52xx_psc_spi.c: In function 'mpc52xx_psc_spi_port_config':
> drivers/spi/mpc52xx_psc_spi.c:350: warning: passing argument 1 of
> 'out_be16' from incompatible pointer type

I've got a patch for these already in my tree.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
