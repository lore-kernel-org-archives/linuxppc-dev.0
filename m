To: Robin Gilks <robin.gilks@tait.co.nz>
Cc: linuxppc mail list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: wdt_mpc8xx documentation 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 18 Dec 2003 17:32:13 +1300."
             <3FE12DCD.10609@tait.co.nz>
Date: Fri, 19 Dec 2003 21:30:29 +0100
Message-Id: <20031219203034.392F6C5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3FE12DCD.10609@tait.co.nz> you wrote:
>
> Whilst rummaging about the PPC development tree I came across the
> Siemens/SGI/Denx watchdog driver for the mpc8xx. It references a man
> page which so far I've not been able to find (man wdt_mpx8xx(4)) so I'm
> a bit clueless about what the monitor chain code does.

In the top directory of the Linux source tree, type:

	man Documentation/man4/wdt_mpc8xx.4

> It doesn't seem to relate to the generic watchdog_api.txt in the kernel
> documentation (at least the defines don't seem to tie in with any of the
>   ioctl options).

You are right; this watchdog driver provides  a  very  different  API
with a few pretty powerful options (like escalation strategies etc.)

> Any help here appreciated.

Hope this helps.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A fanatic is a person who can't change his mind and won't change  the
subject.                                          - Winston Churchill

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
