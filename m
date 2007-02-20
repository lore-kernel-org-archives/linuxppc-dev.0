Return-Path: <ami@waves.com>
Received: from dcmail1.waves.com (dcmail1.waves.com [12.34.136.6])
	by ozlabs.org (Postfix) with SMTP id 2A30CDDDCA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Feb 2007 01:41:06 +1100 (EST)
From: "Ami Levi Waves" <ami@waves.com>
To: "'Steve Iribarne \(GMail\)'" <netstv@gmail.com>,
	"'linuxppc-embedded'" <linuxppc-embedded@ozlabs.org>
Subject: RE: 8541E and vector table.
Date: Tue, 20 Feb 2007 15:39:42 +0100
Message-ID: <002d01c754fd$1f030860$0600000a@waves.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <b4b98b690702200620q3c70cba9j2d8046d4451686a1@mail.gmail.com>
Reply-To: ami@waves.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Download the MPC8541 reference manual from Freescale web site.
Look in the chapter that says Exceptions (could be chapter 6)
You'll fine the different vectors addresses + explanations about each
vector.

Ami

> -----Original Message-----
> From: linuxppc-embedded-bounces+ami=3Dwaves.com@ozlabs.org =
[mailto:linuxppc-
> embedded-bounces+ami=3Dwaves.com@ozlabs.org] On Behalf Of Steve =
Iribarne
> (GMail)
> Sent: Tuesday, February 20, 2007 3:21 PM
> To: linuxppc-embedded
> Subject: 8541E and vector table.
>=20
> Hi.
>=20
> I must admit, this stuff always baffles me a bit, so I need someone
> who knows this to explain it to me.
>=20
> I am using an 8541E and my system randomly crashes.  By randomly, I
> mean at different times.  I have a BDI hooked up and it always jumps
> to offset 0x0000_0700
>=20
> I believe this to be a vector table offset, but I need to figure out
> which interrupt it is.  I believe this is a hardware issued, because
> if I look at that value, it looks to be default values.  In other
> words, I don't believe I have it setup.
>=20
> So the question I have is how do I figure out what that interrupt =
vector
> is?
>=20
> Thanks so much.
>=20
> -stv
>=20
> --
> /*
>  * Steve Iribarne
>  * Software Engineer
>  * (aka Grunt)
>  */
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
