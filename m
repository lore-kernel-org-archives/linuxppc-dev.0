To: "somshekar chandrashekar kadam" <ppclinux@rediffmail.com>
Cc: "Ppc Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: bash prompt 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "04 Jul 2002 17:07:53 -0000."
             <20020704170753.14420.qmail@webmail14.rediffmail.com>
Date: Fri, 05 Jul 2002 22:53:44 +0200
Message-Id: <20020705205349.7AE1110342@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

in message <20020704170753.14420.qmail@webmail14.rediffmail.com> you wrote:
>
>          My  kernel serial driver for 8260 is able to give bash
> prompt but its not able to read anything from serial console,bash
> prompt is not at all responding

What do ypu expect from me? To guess what you're doing wrong?

>   when i attach the interrupts its gettting hanged all 8 leds are
> glowing ,if temporarily if i  remove the interrupt handler there
> is no problem of all 8 leds problem ,coming to bash prompt but not
> responding
>
> transmit_chars is happeneing proper but no receive_chars

This can be anything - maybe you just have to disable  hardware  flow
control in your terminal program.

I have absolutely no information about your board  -  do  you  really
assume  I  could  have  any glue what your "all 8 LEDs" could mean? I
have to disappoint you - the quality of my responses  cannot  be  any
better than the information you provide.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Virtual" means never knowing where your next byte is coming from.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
