Return-Path: <g.schardt@fz-juelich.de>
Received: from zam837.fz-juelich.de (zam837.fz-juelich.de [134.94.100.69])
	by ozlabs.org (Postfix) with SMTP id 6103EDDF09
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Nov 2007 01:16:27 +1100 (EST)
Message-ID: <47346BB7.2000009@fz-juelich.de>
Date: Fri, 09 Nov 2007 15:16:23 +0100
From: schardt <g.schardt@fz-juelich.de>
MIME-Version: 1.0
To: MingLiu <eemingliu@hotmail.com>
Subject: Re: Bootloader & Flash
References: <4731A8E3.4020909@fz-juelich.de>
	<BAY138-W14EEE9667CD669878D3BD0B28A0@phx.gbl>
	<47344D70.4050308@fz-juelich.de>
	<BAY138-W21A6D92355C81BE1341628B2840@phx.gbl>
In-Reply-To: <BAY138-W21A6D92355C81BE1341628B2840@phx.gbl>
Content-Type: text/plain;
	charset=GB2312
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Argl :)

The error was so ... simple.
The Flash device is broken. I take a new MiniModul and all things are
running.

Thanks a lot
Georg

MingLiu wrote:
> Hi,
>
> > - I have download the zImage.elf via the EDK flash loader
> > - The flash loader creates a bootloader, this is also running on
> start up :)
>
> What you need to store in flash memory, is not the .elf file. Before
> you use EDK flash loader to burn your linux kernel in flash, .elf file
> should be transfered into .srec file, just like the below reminds you:
> SREC line is corrupted.
>
>
> > But ... It stops with an error-message after a few seconds:
> >
> > EDK Bootloader:
> > Bootloader: Processed (0x)000000b2 S-recordsERROR: SREC line is
> corrupted
> >
> > What now ?
>
> Hopefully it helps.
>
> BR
> Ming
>
> -----------------------------------------------------------------------=
-
> =D3=C3 Windows Live Spaces =D5=B9=CA=BE=B8=F6=D0=D4=D7=D4=CE=D2=A3=AC=D3=
=EB=BA=C3=D3=D1=B7=D6=CF=ED=C9=FA=BB=EE=A3=A1 =C1=CB=BD=E2=B8=FC=B6=E0=D0=
=C5=CF=A2=A3=A1
> <http://spaces.live.com/?page=3DHP>



-------------------------------------------------------------------------=
----------------
-------------------------------------------------------------------------=
----------------
Forschungszentrum J=A8=B9lich GmbH
52425 J=A8=B9lich

Sitz der Gesellschaft: J=A8=B9lich
Eingetragen im Handelsregister des Amtsgerichts D=A8=B9ren Nr. HR B 3498
Vorsitzende des Aufsichtsrats: MinDirig'in B"arbel Brumme-Bothe
Gesch"aftsf=A8=B9hrung: Prof. Dr. Achim Bachem (Vorsitzender), Dr. Ulrich=
 Krafft (stellv.=20
Vorsitzender)
-------------------------------------------------------------------------=
----------------
-------------------------------------------------------------------------=
----------------
