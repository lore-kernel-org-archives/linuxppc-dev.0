MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: microcodepatch
Date: Thu, 25 Oct 2001 08:47:34 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E31459352@kolkrabbi.flaga.is>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kd@flaga.is>
To: "Peter Desnoyers" <pdesnoyers@chinook.com>
Cc: "Linux Embedded ppc (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I will apply this patch.
But the ethernet is crashing before I install the I2C driver.
(The I2C driver is compiled as a module).

K.D.

> -----Original Message-----
> From: Peter Desnoyers [mailto:pdesnoyers@chinook.com]
> Sent: 24. október 2001 19:07
> To: Kári Davíðsson
> Cc: Linux Embedded ppc (E-mail)
> Subject: Re: microcodepatch
>
>
> The I2C driver doesn't work properly with the microcode patch - it
> initializes tbptr and rbptr to 0, not r_tbase and r_rbase, and it uses
> the INIT_TRX command (which the patched code doesn't support)
> instead of
> separate INIT_RX and INIT_TX.
>
> You might want to try the attached minor patch, which works for us.
>
> --
> .....................................................................
>  Peter Desnoyers            (781) 457-1165   pdesnoyers@chinook.com
>  Chinook Communications     (617) 661-1979   pjd@fred.cambridge.ma.us
>  100 Hayden Ave, Lexington MA 02421
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
