To: Robin Gilks <robin.gilks@tait.co.nz>
Cc: linuxppc mail list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PATCH: Another mpc8xx watchdog driver !! 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 07 Jan 2004 11:28:38 +1300."
             <3FFB3696.3010506@tait.co.nz>
Date: Wed, 07 Jan 2004 00:06:37 +0100
Message-Id: <20040106230642.34C45C12DD@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3FFB3696.3010506@tait.co.nz> you wrote:
>
> After looking at several WDT implementations I found that none of them
> really fitted my requirements - lean, 'prod' frequency greater than
> hardware watchdog period and able to operate on 8xx CPUs with no RTC.

Do you really mean RTC here???

> It is based on the code of Florian Schirmer but using kernel timers
> rather than the RTC (as used by the DENX driver). The enable/disable

What do you mean? Our watchdog code does not use any RTC at all.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You can observe a lot just by watchin'.                  - Yogi Berra

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
