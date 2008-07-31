Return-Path: <jonsmirl@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id A2205DDFBD
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 14:08:06 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so193273ywh.39
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 21:08:04 -0700 (PDT)
Message-ID: <9e4733910807302108q689c9c82yb010c75cba770218@mail.gmail.com>
Date: Thu, 31 Jul 2008 00:08:04 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Tony Breeds" <tony@bakeyournoodle.com>
Subject: Re: [PATCH 4/8] Silence warnings in
	arch/powerpc/platforms/52xx/mpc52xx_pci.c
In-Reply-To: <96343fe00bd43a12b1739ff1513ba07224e3f302.1217476198.git.tony@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <cac86e24e42bd05087b43663b687f04df91326ba.1217476198.git.tony@bakeyournoodle.com>
	<96343fe00bd43a12b1739ff1513ba07224e3f302.1217476198.git.tony@bakeyournoodle.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There are some warnings in mpc5200 spi that I haven't looked at....

drivers/spi/mpc52xx_psc_spi.c: In function 'mpc52xx_psc_spi_activate_cs':
drivers/spi/mpc52xx_psc_spi.c:111: warning: passing argument 1 of
'in_be16' from incompatible pointer type
drivers/spi/mpc52xx_psc_spi.c:117: warning: passing argument 1 of
'out_be16' from incompatible pointer type
drivers/spi/mpc52xx_psc_spi.c: In function 'mpc52xx_psc_spi_port_config':
drivers/spi/mpc52xx_psc_spi.c:350: warning: passing argument 1 of
'out_be16' from incompatible pointer type


-- 
Jon Smirl
jonsmirl@gmail.com
