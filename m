Date: Mon, 2 Jun 2003 16:26:56 +1000
From: Erik Christiansen <erik@dd.nec.com.au>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Cc: Ron Flory <ron.flory@adtran.com>
Subject: Re: embedded gcc PPC toolchain questions
Message-ID: <20030602062656.GD833@dd.nec.com.au>
References: <3ED6298C.3070901@adtran.com> <20030529162243.ED346C5492@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20030529162243.ED346C5492@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


in message <3ED6298C.3070901@adtran.com> Ron Flory wrote:

> 4.  I know the question of embedded libc comes up often.  For
>     the most part, we basically need the 'strxxx' and 'memxxx'
>     functions, but 'sprintf' is quite a different critter.  Since
>     we are running an 860, we won't have FP support (and we don't
>     want to deal with emulation).  Do most folks use a hand-patched
>     'sprintf' source file, manually removing the floating-point ops?
>     I've looked into this a few years ago (the gcc sprintf source
>     file is a horror).  Has the 'ulibc' that i've heard about been
>     used with success by anybody on this list for embedded non-linux
>     projects?

Ron,

   We're happily using newlib's sprintf on the mpc850, in a piece of
   seriously embedded non-linux equipment.

   According to my rough notes, µClibc is LGPL, so static linking may not
   be a good idea. Newlib's BSD-like terms seemed more appealing to me.

   http://sources.redhat.com/newlib

   Bill Gatliff wrote an article on it, in the December 2001 issue of
   Embedded Systems Programming.

   There's apparently also dietlibc and sglibc, but I haven't
   investigated either.

Regards,
Erik


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
