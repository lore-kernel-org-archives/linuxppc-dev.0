Message-ID: <BE1C564723B3D21191FD0000F840E39801D81620@rfcmx2.rfc.comm.harris.com>
From: "Brown, David (dbrown03)" <DBrown03@harris.com>
To: "'Christopher Huffine'" <huffine@wopr.nrl.navy.mil>,
        linuxppc-embedded@lists.linuxppc.org
Subject: RE: 823 ports access question
Date: Mon, 28 Aug 2000 10:05:14 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Port D:
  immr->pio.pdpar = 0;
  immr->pio.pddir = 0x1F0;
  if (turnOn)
    immr->pio.pddat |= (1<<(8-led));
  else
    immr->pio.pddat &= ~(1<<(8-led));
--
Dave Brown <dbrown03@harris.com>

> -----Original Message-----
> From: Christopher Huffine [mailto:huffine@wopr.nrl.navy.mil]
> Sent: Monday, August 28, 2000 7:19 AM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: 823 ports access question
>
>
>
> Sorry to write another simplistic question; hopefully
> there is a simplistic answer as well:
>
> I'm trying to figure out to write to specific
> PPC ports.  For example, the Bright Star
> ipEngine I have has LEDs connected to the LCD ports
> from the PowerPC.  I'm looking for the right
> sequence to actually write to these ports and
> get these LEDs to turn on and off.
>
> I've looked in 8xx_immap.h and I start to see
> what I need to make this work (im_lcd), but I'm missing
> the bigger picture.  Anyone have any example
> code for anything like this?
>
> Thanks,
>
> Chris
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
