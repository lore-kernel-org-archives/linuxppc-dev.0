Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 7E31E67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Apr 2005 00:56:40 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 1 Apr 2005 08:56:36 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B85932D@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Manisha Jagadhane" <manisha.vj@gmail.com>, <linuxppc-embedded@ozlabs.org>
Subject: RE: custom board MPC8266
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I remebereed the wrong file.=20
Take a look in arch/ppc/8260_io/uart.c

> -----Original Message-----
> From: Manisha Jagadhane [mailto:manisha.vj@gmail.com]=20
> Sent: Friday, April 01, 2005 00:01
> To: Rune Torgersen; linuxppc-embedded@ozlabs.org
> Subject: Re: custom board MPC8266
>=20
> Thanks for the reply.=20
> I have seen the file arch/ppc/8260_io/commproc.c, but there is nowhere
> given where to configure the SMC1/SMC2/SCC1/SCC2 as serial console. In
> the .config file, whether we have to set CONFIG_SCC_CONSOLE=3Dy option
> and in this .config file, is it required to do any configuration to
> set SMC1 as serial console?
>=20
> Please clarify.
>=20
> Thanking you in advance.
>=20
> Regards,
> Manisha
>=20
>=20
> On Mar 30, 2005 7:57 PM, Rune Torgersen <runet@innovsys.com> wrote:
> > If I remember correctly: You have to edit the
> > arch/ppc/82xx_io/commproc.c file (I think) to set up which=20
> serial port
> > is used for console port.
> >=20
> > > -----Original Message-----
> > > From: linuxppc-embedded-bounces@ozlabs.org
> > > [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of
> > > Manisha Jagadhane
> > > Sent: Wednesday, March 30, 2005 05:32
> > > To: linuxppc-embedded@ozlabs.org
> > > Subject: custom board MPC8266
> > >
> > > Hi,
> > >
> > > I am using custom board based on MPC8266 processor. I have
> > > successfully ported U-Boot 1.1.1 on it. I have used SMC1 as serial
> > > port in the board. Does the 2.4.24 kernel version for ppc supports
> > > SMC1 as serial console? Which configuration I have to give in the
> > > .config file to configure SMC1 as serial console? Which board's
> > > defconfig file  shall I take as a reference and which=20
> kernel version
> > > shall I use?
> > >
> > > Please help me in this regard.
> > >
> > > Thanking you in advance.
> > >
> > > Regards,
> > >
> > > Manisha.
> > > _______________________________________________
> > > Linuxppc-embedded mailing list
> > > Linuxppc-embedded@ozlabs.org
> > > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> > >
> > >
> >
>=20
>=20
