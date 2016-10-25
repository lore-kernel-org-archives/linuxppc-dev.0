Return-Path: <hongtao.jia@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0051.outbound.protection.outlook.com [104.47.2.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2xv61rG9zDvm9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 13:29:54 +1100 (AEDT)
From: Troy Jia <hongtao.jia@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>
CC: "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com"
 <edubezval@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Scott Wood
 <scott.wood@nxp.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V2 1/5] powerpc/mpc85xx: Update TMU device tree node for
 T1040/T1042
Date: Tue, 25 Oct 2016 02:29:46 +0000
Message-ID: <AM4PR0401MB18431A1DD9E2061FC71414D3EBA80@AM4PR0401MB1843.eurprd04.prod.outlook.com>
References: <1475995626-14049-1-git-send-email-hongtao.jia@nxp.com>
 <20161024083654.GB30578@tiger>
In-Reply-To: <20161024083654.GB30578@tiger>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo@kernel.org]
> Sent: Monday, October 24, 2016 4:37 PM
> To: Troy Jia <hongtao.jia@nxp.com>
> Cc: rui.zhang@intel.com; edubezval@gmail.com; robh+dt@kernel.org; Scott W=
ood
> <scott.wood@nxp.com>; devicetree@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH V2 1/5] powerpc/mpc85xx: Update TMU device tree node =
for
> T1040/T1042
>=20
> On Sun, Oct 09, 2016 at 02:47:02PM +0800, Jia Hongtao wrote:
> > From: Hongtao Jia <hongtao.jia@nxp.com>
> >
> > SoC compatible string and endianness property are added according to
> > the new bindings.
>=20
> The commit log doesn't seem to match the actual changes.  Same for patch =
2/5.

Right. I just revise the log and sent a new version. Please help to review.
Thanks.

-Hongtao.

>=20
> >
> > Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
> > ---
> > Changes for V2:
> > * Rebase on latest linux-next tree (next-20161006).
> >
> >  arch/powerpc/boot/dts/fsl/t1040si-post.dtsi | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
> > b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
> > index 44e399b..145c7f4 100644
> > --- a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
> > +++ b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
> > @@ -526,7 +526,7 @@
> >
> >  				       0x00030000 0x00000012
> >  				       0x00030001 0x0000001d>;
> > -		#thermal-sensor-cells =3D <0>;
> > +		#thermal-sensor-cells =3D <1>;
> >  	};
> >
> >  	thermal-zones {
> > @@ -534,7 +534,7 @@
> >  			polling-delay-passive =3D <1000>;
> >  			polling-delay =3D <5000>;
> >
> > -			thermal-sensors =3D <&tmu>;
> > +			thermal-sensors =3D <&tmu 2>;
> >
> >  			trips {
> >  				cpu_alert: cpu-alert {
> > --
> > 2.1.0.27.g96db324
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
