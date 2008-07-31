Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 2EA17DDF0D
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 14:21:57 +1000 (EST)
Date: Thu, 31 Jul 2008 14:21:51 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 4/8] Silence warnings in
	arch/powerpc/platforms/52xx/mpc52xx_pci.c
Message-ID: <20080731042150.GW20457@bakeyournoodle.com>
References: <cac86e24e42bd05087b43663b687f04df91326ba.1217476198.git.tony@bakeyournoodle.com>
	<96343fe00bd43a12b1739ff1513ba07224e3f302.1217476198.git.tony@bakeyournoodle.com>
	<9e4733910807302108q689c9c82yb010c75cba770218@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <9e4733910807302108q689c9c82yb010c75cba770218@mail.gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 31, 2008 at 12:08:04AM -0400, Jon Smirl wrote:
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

Right drivers/* is harder, and wont be affected by the addition of
-Werror in arch/powerpc

We'll get there eventiually.

Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!
