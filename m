Message-Id: <5.0.0.19.2.20000908122645.01c84a80@mail.munich.netsurf.de>
Date: Fri, 08 Sep 2000 12:33:58 +0200
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: newer xfree86 4.0.1 patches
Cc: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michel D?nzer <daenzerm@student.ethz.ch>,
        linuxppc-dev@lists.linuxppc.org,
        linux-apus-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.21.0009081235530.7007-100000@idd-01.imbc.gr>
References: <00090723551703.31531@enzo.bigblue.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 11:57 08.09.00, Kostas Gewrgiou wrote:

>On Thu, 7 Sep 2000, Franz Sirl wrote:
>
> > > I can't speak about XF4, but with XF3 all of these work out-of-the-box if
> > > you disable Xkb (using kernel keycodes). If you enable Xkb, it also
> works,
> > > but then you need the special X keymaps (for those that are
> available) (no
> > > surprise).
> > >
> > > And I'd say `everything else works fine if you use _MEDIUMRAW_ instead of
> > > RAW'.
> >
> > Nope, you need to compile xf3/4 with ASSUME_CUSTOM_KEYCODES undefined _and_
> > use RAW keyboard mode, otherwise it won't work correctly for some keys and
> > XKB. Tested that on PC and PMac, cause I wanted to be sure that my xf4
> patch
> > is as short as possible.
> >
>
>   What is the problem with MEDIUMRAW in the input layer ? we still can't use
>RAW for the old kernels so we will have to stick with MEDIUMRAW.
>In your patch you use RAW only when the at keycodes are used so its ok.

Kostas, there's no problem with MEDIUMRAW and ADB keycodes, but we were
talking about CHRP/PReP, which use PS2 keyboards and must use RAW mode with
ASSUME_CUSTOM_KEYCODES undefined to work as expected with XKB. You should
know, you did extensive testing in this area :-).

>PS> There is a discussion in xfree about redesigning the keyboard driver
>but don't expect to see any changes in the near future.

Yeah, using the /dev/input/eventX devices for keyboard and mouse input
would greatly simplify the situation and prepare us for real
multihead/multiuser operation.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
