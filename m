From: "Stephan Linke" <Stephan.Linke@epygi.de>
To: "Flavio Pereira" <Flavio.Pereira@za.flextronics.com>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Accessing MPC862 registers 
Date: Wed, 5 Feb 2003 13:59:14 +0100
Message-ID: <FCEAKDJJAPHPLJFINDAJAEHOCNAA.Stephan.Linke@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-reply-to: <742AC4678EF8464697DDDFE3B40F6ECD07E248@SRV-MAILRND.azisa.co.za>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Flavio,

on 862 the internal memory mapped registers are not like plane memory. Only several addresses can actualy be accessed. If you try no
access an non existant register address you cause a bus error.
For that reason you have to consult the manual before you access any address in the IMMR area and in most cases a simple dump tries
to access an area that is to large to avoid invalid accesses.

Regards, Stephan

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Flavio
> Pereira
> Sent: Mittwoch, 5. Februar 2003 13:48
> To: LinuxPPC-Embedded
> Subject: Accessing MPC862 registers
>
>
>
> Hi all
>
> I'm hoping that someone can help me here. I'm using the TQM8xxL module
> with a MPC862 processor on board. With minor changes to the pin
> configurations for the ethernet controller I have gotten U-boot and
> Linux to work without any issues. However from my BDI2000 shell, with my
> IMMR set to 0xFFF00000 (confirmed), I cannot do memory dumps for the
> region 0xFFF00000 - 0xFFF02000. From FFF02000 (DP-RAM) the memory
> accesses seem fine. The same goes for the u-boot shell. Obviously u-boot
> and linux have managed to access these registers, else the system would
> not start? How do I go about doing direct memory accesses to the MPC's
> registers which are located from 0xFFF00000 to 0xFFF00DFF from either
> u-boot or the BDI shell?
>
> Regards
> Flavio Pereira
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
