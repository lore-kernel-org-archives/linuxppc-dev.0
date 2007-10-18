Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6EDBFDDF2D
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 23:47:07 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l9IDkpxi000442
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 06:46:58 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l9IDkjRx013270
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 08:46:46 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v3 9/9] add MPC837x MDS board default device tree
Date: Thu, 18 Oct 2007 21:46:44 +0800
Message-ID: <989B956029373F45A0B8AF0297081890019B5BCD@zch01exm26.fsl.freescale.net>
In-Reply-To: <09B82C85-E2DE-46AD-8ABC-B7A261BAFF6D@kernel.crashing.org>
References: <1192195728-24189-1-git-send-email-leoli@freescale.com>
	<1192195728-24189-2-git-send-email-leoli@freescale.com>
	<1192195728-24189-3-git-send-email-leoli@freescale.com>
	<1192195728-24189-4-git-send-email-leoli@freescale.com>
	<1192195728-24189-5-git-send-email-leoli@freescale.com>
	<1192195728-24189-6-git-send-email-leoli@freescale.com>
	<1192195728-24189-7-git-send-email-leoli@freescale.com>
	<1192195728-24189-8-git-send-email-leoli@freescale.com>
	<1192195728-24189-9-git-send-email-leoli@freescale.com>
	<1192195728-24189-10-git-send-email-leoli@freescale.com>
	<20071015003703.GA14108@localhost.localdomain>
	<09B82C85-E2DE-46AD-8ABC-B7A261BAFF6D@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"David Gibson" <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Wednesday, October 17, 2007 9:59 PM
> To: David Gibson
> Cc: Li Yang-r58472; paulus@samba.org; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH v3 9/9] add MPC837x MDS board default device tree
>=20
>=20
> On Oct 14, 2007, at 7:37 PM, David Gibson wrote:
>=20
> > On Fri, Oct 12, 2007 at 09:28:48PM +0800, Li Yang wrote:
> >> Signed-off-by: Li Yang <leoli@freescale.com>
> >> ---
> >>  arch/powerpc/boot/dts/mpc8377_mds.dts |  288 +++++++++++++++++++++
> >> +++++++++
> >>  arch/powerpc/boot/dts/mpc8378_mds.dts |  268 +++++++++++++++++++++
> >> +++++++
> >>  arch/powerpc/boot/dts/mpc8379_mds.dts |  308 +++++++++++++++++++++
> >> ++++++++++++
> >>  3 files changed, 864 insertions(+), 0 deletions(-)  create mode=20
> >> 100644 arch/powerpc/boot/dts/mpc8377_mds.dts
> >>  create mode 100644 arch/powerpc/boot/dts/mpc8378_mds.dts
> >>  create mode 100644 arch/powerpc/boot/dts/mpc8379_mds.dts
> >>
> >> diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts
> >> b/arch/powerpc/boot/dts/mpc8377_mds.dts
> > [snip]
> >> +	soc837x@e0000000 {
> >> +		#address-cells =3D <1>;
> >> +		#size-cells =3D <1>;
> >> +		device_type =3D "soc";
> >> +		ranges =3D <0 e0000000 00100000>;
> >> +		reg =3D <e0000000 00000200>;
> >> +		bus-frequency =3D <0>;
> >> +
> >> +		wdt@200 {
> >> +			device_type =3D "watchdog";
> >
> > Drop this device_type.
> >
> >> +			compatible =3D "mpc83xx_wdt";
> >> +			reg =3D <200 100>;
> >> +		};
> >> +
> >> +		i2c@3000 {
> >> +			device_type =3D "i2c";
> >
> > And this one.
>=20
> I've asked Leo to leave this one as all other fsl boards do=20
> this and the code depends on it.  There was some discussion=20
> about this but I wasn't sure if it was closed or not.

I'm afraid not only i2c but also watchdog and spi need device_type now.
Shall we proceed removing the type check?

- Leo
