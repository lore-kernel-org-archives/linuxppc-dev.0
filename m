Return-Path: <geert@linux-m68k.org>
Date: Tue, 18 Oct 2005 09:50:26 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
To: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <4354235B.8090608@hogyros.de>
Message-ID: <Pine.LNX.4.62.0510180947220.6283@numbat.sonytel.be>
References: <17227.44943.714106.911471@cargo.ozlabs.ibm.com>
	<434BB09B.9070605@hogyros.de>
	<17235.33942.754076.419504@cargo.ozlabs.ibm.com>
	<4354235B.8090608@hogyros.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux/PPC on APUS development <linux-apus-devel@lists.sourceforge.net>,
	linuxppc64-dev@ozlabs.org
Subject: Re: merge progress
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 18 Oct 2005, Simon Richter wrote:
> Paul Mackerras schrieb:
> > Hmmm, probably should work off the merge tree.
> 
> Good, then I'll fast-forward them there.
> 
> > However, we decided at
> > OLS that platforms would require a device tree before being merged.
> > Have you looked at creating a suitable flattened device tree blob with
> > dtc?  (If not, you can continue to compile with ARCH=ppc for now.)
> 
> In fact my current plan is to move away from m68k bootinfo (which APUS
> borrows so you can use the same bootloader) towards a flattened dev tree

Is requiring a flattened device tree really the right approach to take, for
APUS? APUS borrows from/shares with m68k a lot of code.

BTW, why do you want to move away from m68k bootinfo (apart from using a
flattened device tree)?

> passed in from the bootloader. For that, however, we need a new
> bootloader first, which is dependant on AmigaOS binutils/gcc.
> 
> So I guess it will be ARCH=ppc until the new bootloader is ready.

Happy hacking!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
