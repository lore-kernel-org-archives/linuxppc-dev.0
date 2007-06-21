Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-1.cisco.com (sj-iport-1-in.cisco.com [171.71.176.70])
	by ozlabs.org (Postfix) with ESMTP id D7368DDE2F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Jun 2007 22:30:08 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: General question on upgrading Linux version
Date: Thu, 21 Jun 2007 05:29:15 -0700
Message-ID: <F795765B112E7344AF36AA911279641502D1A3FF@xmb-sjc-212.amer.cisco.com>
In-Reply-To: <33351C82-D56D-4414-81F1-328D36A7993D@freescale.com>
From: "Bizhan Gholikhamseh \(bgholikh\)" <bgholikh@cisco.com>
To: "Andy Fleming" <afleming@freescale.com>
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

=20

> -----Original Message-----
> From: Andy Fleming [mailto:afleming@freescale.com]=20
> Sent: Wednesday, June 20, 2007 2:52 PM
> To: Bizhan Gholikhamseh (bgholikh)
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: General question on upgrading Linux version
>=20
>=20
> On Jun 20, 2007, at 16:29, Bizhan Gholikhamseh ((bgholikh)) wrote:
>=20
> > Hi All,
> > We are using MPC8541 processor from freescale. Our current kernel=20
> > version is based on 2.6.11 plus some patches provided by Freescale.
> > I would like to update our Kernel version to a more recent version.
> > I would greatly appreciate if you could provide me with=20
> some general=20
> > guideline on how to proceed .....
>=20
> You should be able to check out the latest sources from=20
> git:// git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

The current stable kernel release is 2.6.21. Could I use that tree
instead ?

>=20
> You will probably also need a newer u-boot from here:
>=20
> git://www.denx.de/git/u-boot-mpc85xx.git
Currently we are using uboot 1.2. Do I have to update the u-boot version
also or I can bypass that for now?
Thanks,
Bizhan

>=20
> Please tell me if you have any problems using these.
>=20
> Andy
>=20
