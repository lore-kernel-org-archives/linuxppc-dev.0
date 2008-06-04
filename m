Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from IE1EHSOBE001.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id 48A1CDDEC6
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jun 2008 09:18:32 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: linux 2.6 hangs at __delay function on Viretx 4 board
Date: Wed, 4 Jun 2008 16:18:08 -0700
In-Reply-To: <921B6E79C3E18642BFFC1C8633C430DBDDD3FA@CA1EXCLV07.adcorp.kla-tencor.com>
References: <17222725.post@talk.nabble.com><20080514150139.E258D8D006F@mail70-va3.bigfish.com><17276753.post@talk.nabble.com><20080516162807.2132E181804D@mail89-sin.bigfish.com><17454696.post@talk.nabble.com><17482754.post@talk.nabble.com><20080528140800<20080604212233.37F44130004F@mail123-sin.bigfish.com>
	<921B6E79C3E18642BFFC1C8633C430DBDDD3FA@CA1EXCLV07.adcorp.kla-tencor.com>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Howard, Marc" <Marc.Howard@KLA-Tencor.com>,
	"John Linn" <linnj@xilinx.com>, "Peter Korsgaard" <jacmet@sunsite.dk>,
	"swamydp" <swamydp@gmail.com>
Message-ID: <20080604231825.9C3B5568066@mail38-dub.bigfish.com>
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

In 10.1, it is actually free...

> -----Original Message-----
> From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of Howard,
Marc
> Sent: Wednesday, June 04, 2008 2:45 PM
> To: John Linn; Peter Korsgaard; swamydp
> Cc: linuxppc-embedded@ozlabs.org
> Subject: RE: linux 2.6 hangs at __delay function on Viretx 4 board
> =

> Every year at the Embedded Systems Conference I would complain to the
> Xilinix folks about the 16550 not being free.  This year I complained
&
> they told me that even though it is listed as a purchased core when
you
> go to "buy" it you get it for free.  This was just prior to the 10.x
> release.
> =

> Marc W Howard
> =

> > -----Original Message-----
> > From:
> > linuxppc-embedded-bounces+marc.howard=3Dkla-tencor.com@ozlabs.or
> g [mailto:linuxppc-embedded-bounces+marc.howard=3Dkla->
> tencor.com@ozlabs.org] On Behalf Of John Linn
> > Sent: Wednesday, June 04, 2008 2:23 PM
> > To: Peter Korsgaard; swamydp
> > Cc: linuxppc-embedded@ozlabs.org
> > Subject: RE: linux 2.6 hangs at __delay function on Viretx 4 board
> >
> > Hi Peter,
> >
> > Yes you need to enable UARTLITE as the console in the kernel
> > configuration.
> >
> > You have the command line syntax, ttyUL0, correct.
> >
> > They have now changed the UART 16550 to be a free core in the EDK,
not
> > sure which version of the EDK that happened.
> >
> > Thanks,
> > John
> >
> > -----Original Message-----
> > From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
> > [mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org]
On
> > Behalf Of Peter Korsgaard
> > Sent: Wednesday, June 04, 2008 2:56 AM
> > To: swamydp
> > Cc: linuxppc-embedded@ozlabs.org
> > Subject: Re: linux 2.6 hangs at __delay function on Viretx 4 board
> >
> > >>>>> "swamydp" =3D=3D swamydp  <swamydp@gmail.com> writes:
> >
> >  swamydp> Hi John
> >
> >  swamydp> I am using UARTLITE as serial console. I do not have
license
> >  swamydp> for UART 16550.  I have enabled the drivers for uartlite
in
> >  swamydp> menuconfig while configuring the kernel. I have tested all
> >  swamydp> combinations for the kernel command line - tty0, ttyUL0,
> >  swamydp> ttyl0, ttyS0 but could not get uartlite to output kernel
> >  swamydp> printk messages.
> >
> > Correct syntax is console=3DttyUL0
> >
> >  swamydp> Since I am using uartlite , the following settings are
> >  swamydp> turned off in menuconfig
> >
> >  swamydp> CONFIG_SERIAL_8250=3Dn
> >  swamydp> CONFIG_SERIAL_8250_CONSOLE=3Dn
> >
> > Do you have console on uartlite (CONFIG_SERIAL_UARTLITE_CONSOLE)
> > enabled?
> >
> > --
> > Bye, Peter Korsgaard
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
> >
> > This email and any attachments are intended for the sole use
> > of the named recipient(s) and contain(s) confidential
> > information that may be proprietary, privileged or
> > copyrighted under applicable law. If you are not the intended
> > recipient, do not read, copy, or forward this email message
> > or any attachments. Delete this email message and any
> > attachments immediately.
> >
> >
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
