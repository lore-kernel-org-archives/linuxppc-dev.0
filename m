Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id E207FDDD09
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Sep 2007 07:18:12 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so388913wag
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Sep 2007 14:18:11 -0700 (PDT)
Message-ID: <9e4733910709191418o1fba9009gdc75c6bdb56fccd1@mail.gmail.com>
Date: Wed, 19 Sep 2007 17:18:11 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Domen Puncer" <domen@coderock.org>
Subject: Re: [PATCH] phy: export phy_mii_ioctl
In-Reply-To: <9e4733910709191144l6ddb66eaq84f3d1488bcf1443@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070810095153.GC13994@moe.telargo.com>
	<fa686aa40709030857j6c36c87ek60215f812864ee0f@mail.gmail.com>
	<20070915121444.GA19857@nd47.coderock.org>
	<20070917095334.GA4546@powerlinux.fr>
	<20070917202140.GB2642@nd47.coderock.org>
	<9e4733910709171508s76c842c8hca236249617cbb44@mail.gmail.com>
	<20070918151622.GD32628@nd47.coderock.org>
	<9e4733910709181217v417438s85bb9e6b4ad4b475@mail.gmail.com>
	<20070919115621.GI32628@nd47.coderock.org>
	<9e4733910709191144l6ddb66eaq84f3d1488bcf1443@mail.gmail.com>
Cc: netdev@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/19/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> This needs a cleanup too, but it is unrelated....

Another set of related warnings that need clean up....

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
