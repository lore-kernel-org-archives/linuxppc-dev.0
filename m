From: "Jacky Wang" <jacky@premierme.com.tw>
To: <boehringer@snom.de>, "Matthew Locke" <mlocke@mvista.com>
Cc: "Fend Matthias" <mfend@harris.com>, <jimmlin@solomon.com.tw>,
	"linuxppc" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: AW: Does anyone port m8xx_pcmcia driver to Linux Kernel   successfully?
Date: Fri, 26 Apr 2002 17:55:03 +0800
Message-ID: <NFBBLKLHNAGPKBMPDMALOENEKAAA.jacky@premierme.com.tw>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3CC91BB5.D0F18DA6@snom.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sven,

Sounds great!!

Would you mind to standardize the proceddures for us?

Jacky

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of
> Sven Boehringer
> Sent: Friday, April 26, 2002 5:20 PM
> To: Matthew Locke
> Cc: Fend Matthias; jimmlin@solomon.com.tw; linuxppc
> Subject: Re: AW: Does anyone port m8xx_pcmcia driver to Linux
> Kernel successfully?
>
>
> Hi all,
>
> thanks to matthew i can no compile the pcmcia-support.
> But i still have a problem with my pcmcia card, cause i can't bring the
> interface up.
> It seems, that the kernel doesn't assign an interface name like eth1.
> But i really stuck at this point.
> My Hardware is FADS/MPC855T/FEC.I attached the kernel config file to
> this mail.
>
>
> And here ist the dmesg output:
> <snip>
> eth0: FEC ENET Version 0.2, FEC irq 3, MII irq 4, addr 00:04:13:00:00:01
> Linux Kernel Card Services 3.1.22
>   options:  none
> m8xx_pcmcia: Version 0.05, 14-Apr-2002
> m8xx_pcmcia: FADS using SLOT_A with IRQ 13.
> m8xx_pcmcia: Socket 0: MemWin 0: Base 0xe0000000.
> m8xx_pcmcia: Socket 0: MemWin 1: Base 0xe4000000.
> m8xx_pcmcia: Socket 0: MemWin 2: Base 0xe8000000.
> m8xx_pcmcia: Socket 0: MemWin 3: Base 0xec000000.
> m8xx_pcmcia: Socket 0: MemWin 4: Base 0xf0000000.
> m8xx_pcmcia: sock_init(0)
> m8xx_pcmcia: SetSocket(0, flags 0x000, Vcc 0, Vpp 0, io_irq 0, csc_mask
> 0x80)
> m8xx_pcmcia: SetIOMap(0, 0, 0x00, 0 ns, 0x0000-0x0001)
> m8xx_pcmcia: SetIOMap(0, 1, 0x00, 0 ns, 0x0000-0x0001)
> m8xx_pcmcia: SetMemMap(0, 0, 0x00, 0 ns, 0x00000-0x01000, 0x00000)
> m8xx_pcmcia: Socket 0: Mapped memory window 0 at 0xe0000000, OR =
> 0xb8000000.
> m8xx_pcmcia: SetMemMap(0, 0, 0x00, 0 ns, 0x00000-0x01000, 0x00000)
> m8xx_pcmcia: SetMemMap(0, 1, 0x00, 0 ns, 0x00000-0x01000, 0x00000)
> m8xx_pcmcia: Socket 0: Mapped memory window 1 at 0xe4000000, OR =
> 0xb8000000.
> m8xx_pcmcia: SetMemMap(0, 1, 0x00, 0 ns, 0x00000-0x01000, 0x00000)
> m8xx_pcmcia: SetMemMap(0, 2, 0x00, 0 ns, 0x00000-0x01000, 0x00000)
> m8xx_pcmcia: Socket 0: Mapped memory window 2 at 0xe8000000, OR =
> 0xb8000000.
> m8xx_pcmcia: SetMemMap(0, 2, 0x00, 0 ns, 0x00000-0x01000, 0x00000)
> m8xx_pcmcia: SetMemMap(0, 3, 0x00, 0 ns, 0x00000-0x01000, 0x00000)
> m8xx_pcmcia: Socket 0: Mapped memory window 3 at 0xec000000, OR =
> 0xb8000000.
> m8xx_pcmcia: SetMemMap(0, 3, 0x00, 0 ns, 0x00000-0x01000, 0x00000)
> m8xx_pcmcia: SetMemMap(0, 4, 0x00, 0 ns, 0x00000-0x01000, 0x00000)
> m8xx_pcmcia: Socket 0: Mapped memory window 4 at 0xf0000000, OR =
> 0xb8000000.
> m8xx_pcmcia: SetMemMap(0, 4, 0x00, 0 ns, 0x00000-0x01000, 0x00000)
> <snip>
>
> regards,
>
> 	Sven
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
