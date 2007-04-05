Return-Path: <geert@linux-m68k.org>
Received: from hoboe2bl1.telenet-ops.be (hoboe2bl1.telenet-ops.be
	[195.130.137.73]) by ozlabs.org (Postfix) with ESMTP id 76197DDEB7
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Apr 2007 01:56:59 +1000 (EST)
Date: Thu, 5 Apr 2007 17:56:52 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v3] Stop pmac_zilog from abusing 8250's device numbers;
	optionally.
In-Reply-To: <1175784435.2719.18.camel@shinybook.infradead.org>
Message-ID: <Pine.LNX.4.64.0704051732460.17664@anakin>
References: <1175666635.2932.17.camel@shinybook.infradead.org>
	<17939.17962.248566.886449@cargo.ozlabs.ibm.com>
	<1175696383.2774.24.camel@shinybook.infradead.org>
	<20070405.233101.106261123.anemo@mba.ocn.ne.jp>
	<1175784435.2719.18.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Torben Mathiasen <torben@kernel.org>, device@lanana.org,
	alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 5 Apr 2007, David Woodhouse wrote:
> On Thu, 2007-04-05 at 23:31 +0900, Atsushi Nemoto wrote
> > Is major 204 minor 192 already allocated?
> 
> Of course. The reason it took so long to provide this patch after the
> 'pmac_zilog doesn't load' bug got reported was because I was waiting for
> the new allocation.

What about the moratorium on newly assigned numbers?
What about using a dynamically allocated number?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
