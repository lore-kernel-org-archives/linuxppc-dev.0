Date: Fri, 15 Dec 2000 15:38:05 -0700
From: Matt Porter <mporter@mvista.com>
To: Torsten Rissel <torsten.rissel@t-online.de>
Cc: "Linuxppc-Embedded (E-Mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MVME 5100
Message-ID: <20001215153805.E691@beef.az.mvista.com>
References: <01C065EA.89787760@NB2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <01C065EA.89787760@NB2>; from torsten.rissel@t-online.de on Thu, Dec 14, 2000 at 04:25:55PM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Dec 14, 2000 at 04:25:55PM +0100, Torsten Rissel wrote:
> Thanks, but I have already set up a BAT to cover the area from 0xf0000000 - 0xffffffff
> because everything is there on the MVME5100 - the serial ports (via the Hawk external
> registers) [fef88000+], the MPIC [f3f80000+] and the PHC PCI registers [fe000000+].

Right, I have one as well as a similar Hawk-based board that has Linux
on it.

> The CONFIG_ADDRESS and CONFIG_DATA registers are on fe000cf8 and fe00cfc,
> and still writing to the CONFIG_ADDRESS and then reading the CONFIG_DATA sometime
> works and sometimes not !!!??

I can consistently read from and write to config space on my 5100 board
via PPCBUG.  The only thing I can think of is that you have somehow
locked up the Hawk bridge.  I've managaged this on other host bridges
only by getting a PIB locked up and squatting on the bus.

What kernel version are you using as a basis for your port?  Are you
basing the port off the existing prep_*.c support?

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
