Return-Path: <geert@linux-m68k.org>
Received: from witte.sonytel.be (witte.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 8EC8B679F5
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 05:54:22 +1000 (EST)
Date: Wed, 26 Apr 2006 21:46:26 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
To: Wolfgang Denk <wd@denx.de>
Subject: Re: FT u-boot shim 
In-Reply-To: <20060426191957.14C4F353DAC@atlas.denx.de>
Message-ID: <Pine.LNX.4.62.0604262144460.3980@pademelon.sonytel.be>
References: <20060426191957.14C4F353DAC@atlas.denx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 26 Apr 2006, Wolfgang Denk wrote:
> In message <A8793E99-83C1-4FD9-8735-D2E8F98B3003@kernel.crashing.org> you wrote:
> > How would you propose that we handle booting arch/powerpc kernels  
> > from u-boot going forward? (for new board ports and existing board  
> > ports).
> 
> Ideally, I'd like to see a common kernel  interface  for  all  archi-
> tectures,  PowerPC  and ARM and MIPS and ... But last time I dared to
> suggest this I've been told what a nincompoop I am.

Let's hope Linux Darwinism will convergenge to a common kernel interface...

> I will accept what is decided by the P.T.B., but  I  request  not  to
> break backwards compatibility with existing systems.

[ dict ptb -> Physikalisch-Technische Bundesanstalt ? ]

Ah, Powers That Be!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
