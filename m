To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: different device file name when relocating SMC1? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 24 Jul 2004 09:07:46 EDT."
             <Pine.LNX.4.60.0407240816340.11139@localhost.localdomain>
Date: Sun, 25 Jul 2004 18:27:35 +0200
Message-Id: <20040725162740.AF9C3C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.LNX.4.60.0407240816340.11139@localhost.localdomain> you wrote:
>
>       so, simple question -- until now, we've identified the console as
> ttyS0, and it's worked fine.  does relocation require referring to the
> console with a different device file name?  i (vaguely) recall /dev

No.

> entries with names like cpmuart0 or something like that.  given

No.

> relocation, should i be using something other than "ttyS0"?

No. [Unless you changed the driver and/or configured your  system  so
that SMC1 is not the first entry in the port table.]

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Never underestimate the bandwidth of a station wagon full of tapes.
                                -- Dr. Warren Jackson, Director, UTCS

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
