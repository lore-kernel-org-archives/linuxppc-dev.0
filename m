Return-Path: <geert@linux-m68k.org>
Received: from yorgi.telenet-ops.be (yorgi.telenet-ops.be [195.130.133.69])
	by ozlabs.org (Postfix) with ESMTP id 946F5DDE04
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 01:56:59 +1100 (EST)
Received: from monty.telenet-ops.be (monty.telenet-ops.be [195.130.132.56])
	by yorgi.telenet-ops.be (Postfix) with ESMTP id 1A0456827DC
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 15:46:29 +0100 (CET)
Date: Fri, 25 Jan 2008 15:46:24 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH] [NET]: Remove PowerPC code from fec.c
In-Reply-To: <4799F349.9090102@scram.de>
Message-ID: <Pine.LNX.4.64.0801251544480.13060@anakin>
References: <4799F349.9090102@scram.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-m68k@vger.kernel.org, uClinux list <uclinux-dev@uclinux.org>,
	Greg Ungerer <gerg@uclinux.org>, "Kernel,
	Linux" <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Scott Wood <scottwood@freescale.com>, "Garzik, Jeff" <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 25 Jan 2008, Jochen Friedrich wrote:
> fec.c is only used on M68k Coldfire CPUs. Remove leftover
> PowerPC code from this driver.

As per MAINTAINERS, m68knommu is handled by:

UCLINUX (AND M68KNOMMU)
P:	Greg Ungerer
M:	gerg@uclinux.org
L:	uclinux-dev@uclinux.org  (subscribers-only)

I already forwarded a copy of your email to Greg.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
