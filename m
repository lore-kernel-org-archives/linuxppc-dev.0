Date: Mon, 18 Dec 2000 16:34:57 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Matt Porter <mporter@mvista.com>
cc: Torsten Rissel <torsten.rissel@t-online.de>,
        "Linuxppc-Embedded (E-Mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MVME 5100
In-Reply-To: <20001215153805.E691@beef.az.mvista.com>
Message-ID: <Pine.HPX.4.10.10012181630430.3991-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 15 Dec 2000, Matt Porter wrote:

>
> On Thu, Dec 14, 2000 at 04:25:55PM +0100, Torsten Rissel wrote:
> > Thanks, but I have already set up a BAT to cover the area from 0xf0000000 - 0xffffffff
> > because everything is there on the MVME5100 - the serial ports (via the Hawk external
> > registers) [fef88000+], the MPIC [f3f80000+] and the PHC PCI registers [fe000000+].
>
> Right, I have one as well as a similar Hawk-based board that has Linux
> on it.
>
> > The CONFIG_ADDRESS and CONFIG_DATA registers are on fe000cf8 and fe00cfc,
> > and still writing to the CONFIG_ADDRESS and then reading the CONFIG_DATA sometime
> > works and sometimes not !!!??
>
> I can consistently read from and write to config space on my 5100 board
> via PPCBUG.  The only thing I can think of is that you have somehow
> locked up the Hawk bridge.  I've managaged this on other host bridges
> only by getting a PIB locked up and squatting on the bus.

On the MVME2400 (and older Raven/Falcon based boards) the config space by
default is at 0x80000cf8 and 0x8000cfc. Does it mean that on the MVME5100,
the Hawk is reprogrammed by PPCBUG to look like a CHRP system ?

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
