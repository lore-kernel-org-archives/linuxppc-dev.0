To: Robin Gilks <robin.gilks@tait.co.nz>
Cc: linuxppc mail list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PATCH: Another mpc8xx watchdog driver !! 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 07 Jan 2004 12:30:21 +1300."
             <3FFB450D.7060405@tait.co.nz>
Date: Wed, 07 Jan 2004 00:35:34 +0100
Message-Id: <20040106233539.63641C12DD@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3FFB450D.7060405@tait.co.nz> you wrote:
>
> > Do you really mean RTC here???
>
> Yes - the 866 and derivatives (859 etc) do NOT have a Real Time Clock
> block. This means that hooking the RTC interrupt to 'kick the dog' is
> rather difficult :-))

That may be the case. But the watchdog code does not use any  RTC  at
all.

> "It is based on the code of Florian Schirmer but using kernel timers (as
> used by the DENX driver) rather than the RTC."

Have you ever seen a MPC8xx watchdog driver that used RTC for
triggering?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A wise person makes his  own  decisions,  a  weak  one  obeys  public
opinion.                                           -- Chinese proverb

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
