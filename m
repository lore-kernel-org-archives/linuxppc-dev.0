Message-ID: <004001c2c7aa$00637140$870ca8c0@hercules>
From: "Frank Robbins" <Frank.Robbins@Analogue-Micro.com>
To: <acurtis@onz.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <NCBBIINEHIPFGJPLBEIFCEICEBAA.acurtis@onz.com>
Subject: Re: problems with MPC8xx internal RTC !?
Date: Wed, 29 Jan 2003 15:20:44 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


There is no patch .. If we could patch the hardware we would all be happy!

The chip is ill  there was a Mask error when it was originally made. It has
never been fixed on the 860T , and on most of the 855T silicon this was also
the case.. though it was down for a fix on of the errata sheets whether this
has been done I am unsure check www.mot-sps.com

The fix is to use a RTC clock chip and not use the VKAPWR just connect it to
3V3 (Don't leave it disconnected otherwise you will be able fry eggs on the
chip.. it gets hot when left unconnected). Change your hardware to use a RTC
chip or live with the power drain.

Frank

----- Original Message -----
From: "Allen Curtis" <acurtis@onz.com>
To: "Frank Robbins" <Frank.Robbins@Analogue-Micro.com>; "Steven Scholz"
<steven.scholz@imc-berlin.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, January 29, 2003 2:53 PM
Subject: RE: problems with MPC8xx internal RTC !?


> > Just an a side note  has the errata for the RTC been fixed on the
> > MPC855T it
> > is not fixed on the 860T  and I believe this feature is now missing on
> > future MPC 866T, 857 variants.
>
> Do you have a patch you would like to contribute?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
