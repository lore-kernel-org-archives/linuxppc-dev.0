Message-ID: <3A59F4F0.A64CCB35@mvista.com>
Date: Mon, 08 Jan 2001 12:12:16 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: "Bernal, Fernando J" <fernando.bernal@eds.com>
CC: "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: SCC and SMC Implementation
References: <7A62AD36B644D411B0E500508BDF0CECF1245C@usahm016.exmi01.exch.eds.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Bernal, Fernando J" wrote:
>
> I would like to know if someone has implemented the two SMC and the two SCC
> serial ports on an embedded 823 PowerPC.


It's part of the standard kernel release.  I think I finally got
the I/O pin configuration right in the upcoming 2.4 release.  You
may need to manually edit the configuration table in
arch/ppc/8xx_io/uart.c to get the configuration you desire.  It seems
everyone has a different configuration desire that is difficult to
implement in the standard configuration scripts (maybe the upcoming
CML2 will help this).

FYI, the 823 does not have two SCCs, only the 823e does.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
