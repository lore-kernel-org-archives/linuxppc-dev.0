Message-ID: <4071A024.6020005@fh-landshut.de>
Date: Mon, 05 Apr 2004 20:06:28 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
Reply-To: okorpil@fh-landshut.de
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Patch Preview for MVME2100
References: <Pine.LNX.4.33.0404041321400.21042-200000@lux32.if.fh-landshut.de> <20040405172348.GS31152@smtp.west.cox.net>
In-Reply-To: <20040405172348.GS31152@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


- The stuff in arch/ppc/boot/mvme2100 can go.

Figured that out today, too. It won't compile anyway. Thanks.

>- The open_pic.c change shouldn't be needed either.
>
>
Maybe the CONFIG_EPIC_SERIAL_MODE should be set, shouldn't it? Will add
it tomorrow. Should I add that cascade hookup stuff even if there is no
cascaded 8259?

>- Your openpic_initsenses table looks wrong, and is probably the cause
>  of the uart slowness you found.  What you do is only list the IRQs for
>  which you have something, and use openpic_set_sources calls to skip
>  over the gaps.  Look at lopec_init_IRQ and ask if you still have
>  problems.  I hoped to have documented that one well the first time
>  around. :)
>
>
There is one problem - in the LoPEC manual all interrupts are documented
- even if marked unused (I refer to polarity and level/edge). In the
MVME2100 information about that interrupts is N/A. So should I leave
those to 0 still in the initsenses struct?

Thanks for the help,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
