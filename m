Message-Id: <200101081639.f08GdTO23705@denx.local.net>
To: "Bernal, Fernando J" <fernando.bernal@eds.com>
cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: SCC and SMC Implementation 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 08 Jan 2001 10:59:31 EST."
             <7A62AD36B644D411B0E500508BDF0CECF1245C@usahm016.exmi01.exch.eds.com>
Date: Mon, 08 Jan 2001 17:39:28 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <7A62AD36B644D411B0E500508BDF0CECF1245C@usahm016.exmi01.exch.eds.com> you wrote:
>
> I would like to know if someone has implemented the two SMC and the two SCC
> serial ports on an embedded 823 PowerPC.

I have a MPC860 system which works with serial ports  on  both  SMC's
and  all  4  SCC's. I think it should work on 823 and 850 as well (at
least the SMC part is tested).

Which kernel version do you need, 2.2.x or 2.4.x?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You can't have everything... where would you put it?  - Steven Wright

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
