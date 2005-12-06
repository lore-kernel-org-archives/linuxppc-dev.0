Return-Path: <yorksun@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 42FE46887E
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Dec 2005 02:24:06 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	jB6FUlac009209
	for <linuxppc-embedded@ozlabs.org>; Tue, 6 Dec 2005 08:30:47 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id jB6FR3eO009710
	for <linuxppc-embedded@ozlabs.org>; Tue, 6 Dec 2005 09:27:04 -0600 (CST)
From: York Sun <yorksun@freescale.com>
To: zengshuai@sogou.com
In-Reply-To: <31839904.1133852113796.JavaMail.postfix@mx3.mail.sohu.com>
References: <31839904.1133852113796.JavaMail.postfix@mx3.mail.sohu.com>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Dec 2005 09:22:17 -0600
Message-Id: <1133882538.3654.0.camel@york.somerset.freescale.net>
Mime-Version: 1.0
Cc: ppc <linuxppc-embedded@ozlabs.org>
Subject: Re: =?utf-8?b?5Zue5aSNOlJlOg==?= Fw: Anyone using
	CodeWarrior USB TAP?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

No. It doesn't support GDB protocol.

York

On Tue, 2005-12-06 at 14:55 +0800, zengshuai@sogou.com wrote:
> I have a question too.
> Can we use CodeWarrior USB TAP in GDB?
> The CodeWarrior IDE is really expensive.
>=20
> -----  =E5=8E=9F=E6=96=87  -----
> From: York Sun=20
> To: Kim Phillips=20
> Cc: linuxppc-embedded@ozlabs.org=20
> Subject: Re: Fw: Anyone using CodeWarrior USB TAP?
> Sent: Tue Dec 06 03:37:22 CST 2005
>=20
> > Addison,
> >=20
> > I don't know if you can receive this reply since I am not in the mailin=
g
> > list.
> >=20
> > The answer is that the USB TAP can work under Linux. You will need
> > CodeWarrior Linux version. The current version is 2.6. Please contact
> > the sales of channels where you got your board.
> >=20
> > No specific driver is required for Linux. Just kindly remind you to
> > check the writing privilege of /proc/bus/usb/001/* if you not the root
> > user.
> >=20
> > York
> >=20
> >=20
> > On Mon, 2005-12-05 at 13:22 -0600, Kim Phillips wrote:
> > > York, know anything about this?  If you're subscribed, could you answ=
er directly to the list?
> > >=20
> > > Kim
> > >=20
> > > Begin forwarded message:
> > >=20
> > > Date: Mon, 5 Dec 2005 17:05:39 +0000
> > > From: Addison Baldwin <addison.baldwin@gmail.com>
> > > To: linuxppc-embedded@ozlabs.org
> > > Subject: Anyone using CodeWarrior USB TAP?
> > >=20
> > >=20
> > > Hi
> > >=20
> > > I received a MPC8272ADS board from Freescale, and I'm trying to use a
> > > CodeWarrior USB TAB that has been provided with the board. It seems t=
hat
> > > such a device only works under Windows, as I didn't find a driver to =
make it
> > > works under Linux.
> > >=20
> > > I would like to know if anyone have got the CodeWarrior USB working u=
nder
> > > Linux.
> > >=20
> > > Thanks,
> > > Addison
> > >=20
> > >=20
> > >=20
> > --=20
> > York Sun
> > =20
> > This email, and any associated attachments have been classified as:
> > [x] Freescale Semiconductor General Business
> > [ ] Freescale Semiconductor Internal Use Only
> > [ ] Freescale Semiconductor Confidential Proprietary
> >=20
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20
> ------------------------------
> =E6=88=91=E7=8E=B0=E5=9C=A8=E4=BD=BF=E7=94=A8Sogou.com=E7=9A=842G=E9=82=
=AE=E7=AE=B1=E4=BA=86=EF=BC=8C=E4=BD=A0=E4=B9=9F=E6=9D=A5=E8=AF=95=E8=AF=95=
=E5=90=A7!=20
> http://mail.sogou.com/recommend/sogoumail_invite_reg1.jsp?from=3Dsogouinv=
itation&s_EMAIL=3Dzengshuai%40sogou.com&username=3D&FullName=3D&Email=3D&ve=
rify=3De197bd6dbd1fc7f8d6a035729df08d63
>=20
--=20
York Sun
=20
This email, and any associated attachments have been classified as:
[x] Freescale Semiconductor General Business
[ ] Freescale Semiconductor Internal Use Only
[ ] Freescale Semiconductor Confidential Proprietary
