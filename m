Subject: Re: Do I shoot myself in the foot first or HEAD.S?
To: clark@esteem.com
Date: Wed, 19 Jul 2000 11:30:06 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <1.5.4.32.20000719011945.006845c0@pop.esteem.com> from "clark@esteem.com" at Jul 18, 2000 06:19:45 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000719013006.DDA67211@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Conn,

I'll have a shot at the ones I know about:

clark@esteem.com writes:
>         Any tips for a new guy? I just about ready to start trying to port
> linux to our custom MPC850 board.

You mentioned head.S; you shouldn't need to modify it at all. We didn't on our
custom 855T design.

> 1. Is there a FAQ or Doc on porting the kernel to a new design? (please mail
> or direct me to it)

There's the HOWTO at:
    http://members.xoom.com/greyhams/linux/PowerPC-Embedded-HOWTO.html

...
> 3. What do I need to do in the ROM before jumping to HEAD.S other than
> programming the ram timmings in the UPM( I assume HEAD.S is where everything
> starts )?

I suggest porting PPCBOOT to it rather than starting from scratch yourself.
See:
    http://ppcboot.sourceforge.net/

Regards,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
