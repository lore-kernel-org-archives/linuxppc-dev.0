To: "yhxing" <xyuhua_telecom@hotmail.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PCMCIA problem help! 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 21 Apr 2004 17:04:16 +0800."
             <Sea1-DAV39b0zrAXBir0002037c@hotmail.com>
Date: Wed, 21 Apr 2004 18:58:35 +0200
Message-Id: <20040421165840.6506BC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Sea1-DAV39b0zrAXBir0002037c@hotmail.com> you wrote:
>
>   When I use PC card on mpc823, there is some trouble, the card

Which board is this?

> m8xx_pcmcia: Version 0.03, 14-Feb-2000, Magnus Damm
> m8xx_pcmcia: TQM8xxL using SLOT_B with IRQ 13.

You configured for a TQM8xxL board, but from the messages  I've  seen
it  doesn't  look  like a TQM823L to me. Are you absolutely sure that
this is a TQM823L? And do you use U-Boot for loading?

>   What is the matter with it?

I guess it's a misconfigured board.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"The X11 source code style is ATROCIOUS and should not be used  as  a
model."                                                   - Doug Gwyn

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
