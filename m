Reply-To: <PaulFagerburg@RenaissanceNT.com>
From: "Paul Fagerburg" <PaulFagerburg@RenaissanceNT.com>
To: "'Pablo Le?n'" <control@horushardware.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: rpx-lite led question 
Date: Wed, 16 Aug 2000 14:52:42 -0700
Message-ID: <000e01c007cc$4e1621d0$5301a8c0@renaissancent.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <200008162138.XAA29770@denx.local.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We have an RPX-Classic LF, which also has two user-controlled LED's. The
documentation which came with the board, in the Firmware guide, says that
the LED's are controlled by bits 4 and 5 in BCSR0. The RPX Lite is probably
similar if not identical.

-paul

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf
> Of Wolfgang
> Denk
> Sent: Wednesday, August 16, 2000 2:38 PM
> To: Pablo Le?n
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: rpx-lite led question
>
>
>
> Dear Pablo,
>
> in message <200008161901.e7GJ1Qg28132@smtp.wanadoo.es> you wrote:
> >
> > We're trying to develop a tiny driver for accesing the user
> leds of our R=
> > PX-Lite.
> >
> > Any Sample code on writing linux device drivers?
>
> Yepp: see http://www.denx.de/solutions-en.html#Drivers
>
> This includes a simple LED driver for the TQM8xxL systems; the RPX is
> probably not too much different.
>
> > Where can we find the address map of the board's leds?
>
> Ask the vendor / manufacturer?
>
> Hope this helps,
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> The ultimate barrier is one's viewpoint.
>                         - Terry Pratchett, _The Dark Side of the Sun_
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
