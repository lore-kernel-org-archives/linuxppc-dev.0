Return-Path: <geert@linux-m68k.org>
Received: from witte.sonytel.be (witte.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id A15B46884B
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Dec 2005 08:14:21 +1100 (EST)
Date: Sun, 4 Dec 2005 22:13:58 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20051203160020.42d1da3c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0512042212540.15120@pademelon.sonytel.be>
References: <11336368261610-git-send-email-otavio@debian.org>
	<20051203212402.GA2821@gate.ebshome.net>
	<20051203160020.42d1da3c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>, otavio@debian.org
Subject: Re: [PATCH] include/asm-ppc/btext.h: add prototype of btext_init
 function.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 3 Dec 2005, Andrew Morton wrote:
> Eugene Surovegin <ebs@ebshome.net> wrote:
> >  > +extern void __init btext_init(boot_infos_t *bi);
> >  >  extern void btext_welcome(void);
> >  >  extern void btext_prepare_BAT(void);
> >  >  extern void btext_setup_display(int width, int height, int depth, int pitch,
> > 
> >  "__init" should be placed between closing brace and semicolon. For 
> >  more info, see include/linux/init.h
> 
> I don't think it matters much.  Often we just omit it from the declaration
> - it's only required at the definition site

IIRC, on Alpha it's needed/recommended on both, to allow the compiler to
optimize jumps to the same section?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
