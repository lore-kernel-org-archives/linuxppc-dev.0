To: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
Cc: Kent Borg <kentborg@borg.org>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Why ack interrupt before calling handler? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "11 Jun 2003 12:33:42 +0200."
             <1055327622.26152.70.camel@spawn>
Date: Wed, 11 Jun 2003 13:28:34 +0200
Message-Id: <20030611112839.5C306C5FD7@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1055327622.26152.70.camel@spawn> you wrote:
>
> ps. and never ever use edge triggered interrupts

Oops? Why not?

We use them all the time, and find  that  they  are  much  easier  to
handle than level triggered interrupts.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
How many QA engineers does it take to screw in a lightbulb? 3:  1  to
screw it in and 2 to say "I told you so" when it doesn't work.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
