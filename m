Return-Path: <Marc.Howard@KLA-Tencor.com>
Received: from ca1mail04.kla-tencor.com (mailout04.kla-tencor.com
	[192.146.1.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7167EDE418
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jun 2008 07:44:40 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: linux 2.6 hangs at __delay function on Viretx 4 board
Date: Wed, 4 Jun 2008 14:44:33 -0700
Message-ID: <921B6E79C3E18642BFFC1C8633C430DBDDD3FA@CA1EXCLV07.adcorp.kla-tencor.com>
In-Reply-To: <20080604212233.37F44130004F@mail123-sin.bigfish.com>
References: <17222725.post@talk.nabble.com><20080514150139.E258D8D006F@mail70-va3.bigfish.com><17276753.post@talk.nabble.com><20080516162807.2132E181804D@mail89-sin.bigfish.com><17454696.post@talk.nabble.com><17482754.post@talk.nabble.com><20080528140800
	<20080604212233.37F44130004F@mail123-sin.bigfish.com>
From: "Howard, Marc" <Marc.Howard@KLA-Tencor.com>
To: "John Linn" <John.Linn@xilinx.com>, "Peter Korsgaard" <jacmet@sunsite.dk>,
	"swamydp" <swamydp@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Every year at the Embedded Systems Conference I would complain to the
Xilinix folks about the 16550 not being free.  This year I complained &
they told me that even though it is listed as a purchased core when you
go to "buy" it you get it for free.  This was just prior to the 10.x
release.

Marc W Howard=20

> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+marc.howard=3Dkla-tencor.com@ozlabs.or
g [mailto:linuxppc-embedded-bounces+marc.howard=3Dkla->
tencor.com@ozlabs.org] On Behalf Of John Linn
> Sent: Wednesday, June 04, 2008 2:23 PM
> To: Peter Korsgaard; swamydp
> Cc: linuxppc-embedded@ozlabs.org
> Subject: RE: linux 2.6 hangs at __delay function on Viretx 4 board
>=20
> Hi Peter,
>=20
> Yes you need to enable UARTLITE as the console in the kernel
> configuration.
>=20
> You have the command line syntax, ttyUL0, correct.
>=20
> They have now changed the UART 16550 to be a free core in the EDK, not
> sure which version of the EDK that happened.
>=20
> Thanks,
> John
>=20
> -----Original Message-----
> From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] =
On
> Behalf Of Peter Korsgaard
> Sent: Wednesday, June 04, 2008 2:56 AM
> To: swamydp
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: linux 2.6 hangs at __delay function on Viretx 4 board
>=20
> >>>>> "swamydp" =3D=3D swamydp  <swamydp@gmail.com> writes:
>=20
>  swamydp> Hi John
>=20
>  swamydp> I am using UARTLITE as serial console. I do not have license
>  swamydp> for UART 16550.  I have enabled the drivers for uartlite in
>  swamydp> menuconfig while configuring the kernel. I have tested all
>  swamydp> combinations for the kernel command line - tty0, ttyUL0,
>  swamydp> ttyl0, ttyS0 but could not get uartlite to output kernel
>  swamydp> printk messages.
>=20
> Correct syntax is console=3DttyUL0
>=20
>  swamydp> Since I am using uartlite , the following settings are
>  swamydp> turned off in menuconfig
>=20
>  swamydp> CONFIG_SERIAL_8250=3Dn
>  swamydp> CONFIG_SERIAL_8250_CONSOLE=3Dn
>=20
> Do you have console on uartlite (CONFIG_SERIAL_UARTLITE_CONSOLE)
> enabled?
>=20
> --=20
> Bye, Peter Korsgaard
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20
> This email and any attachments are intended for the sole use=20
> of the named recipient(s) and contain(s) confidential=20
> information that may be proprietary, privileged or=20
> copyrighted under applicable law. If you are not the intended=20
> recipient, do not read, copy, or forward this email message=20
> or any attachments. Delete this email message and any=20
> attachments immediately.
>=20
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
