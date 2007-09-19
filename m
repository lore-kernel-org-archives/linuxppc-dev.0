Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.185])
	by ozlabs.org (Postfix) with ESMTP id C5C7CDDEF5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Sep 2007 04:44:57 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so235650rvf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Sep 2007 11:44:56 -0700 (PDT)
Message-ID: <9e4733910709191144l6ddb66eaq84f3d1488bcf1443@mail.gmail.com>
Date: Wed, 19 Sep 2007 14:44:56 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Domen Puncer" <domen@coderock.org>
Subject: Re: [PATCH] phy: export phy_mii_ioctl
In-Reply-To: <20070919115621.GI32628@nd47.coderock.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070810095153.GC13994@moe.telargo.com>
	<20070902074143.GB2642@nd47.coderock.org>
	<fa686aa40709030857j6c36c87ek60215f812864ee0f@mail.gmail.com>
	<20070915121444.GA19857@nd47.coderock.org>
	<20070917095334.GA4546@powerlinux.fr>
	<20070917202140.GB2642@nd47.coderock.org>
	<9e4733910709171508s76c842c8hca236249617cbb44@mail.gmail.com>
	<20070918151622.GD32628@nd47.coderock.org>
	<9e4733910709181217v417438s85bb9e6b4ad4b475@mail.gmail.com>
	<20070919115621.GI32628@nd47.coderock.org>
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

On 9/19/07, Domen Puncer <domen@coderock.org> wrote:
> Patch at the end.
> When compiled as module use "modprobe fec_mpc52xx mac=foo",
> when built-in add to boot line: "fec_mpc52xx.mac=foo"

This patch series is working for me now.

This needs a cleanup too, but it is unrelated....

  CC      drivers/serial/mpc52xx_uart.o
drivers/serial/mpc52xx_uart.c: In function 'mpc52xx_console_setup':
drivers/serial/mpc52xx_uart.c:760: warning: format '%lx' expects type
'long unsigned int', but argument 2 has type 'resource_size_t'
drivers/serial/mpc52xx_uart.c: In function 'mpc52xx_uart_of_probe':
drivers/serial/mpc52xx_uart.c:978: warning: format '%lx' expects type
'long unsigned int', but argument 3 has type 'resource_size_t'



-- 
Jon Smirl
jonsmirl@gmail.com
