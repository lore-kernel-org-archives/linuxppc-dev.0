Return-Path: <madalin.bucur@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0064.outbound.protection.outlook.com [104.47.2.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tYV7l6WYfzDvRX
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 18:12:51 +1100 (AEDT)
From: Madalin-Cristian Bucur <madalin.bucur@nxp.com>
To: Scott Wood <oss@buserror.net>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [v2, 2/3] powerpc/fsl/dts: add QMan and BMan portal nodes on t1024
Date: Wed, 7 Dec 2016 07:12:45 +0000
Message-ID: <AM4PR04MB1604989338D17E495C655320EC850@AM4PR04MB1604.eurprd04.prod.outlook.com>
References: <1481030019-31854-2-git-send-email-madalin.bucur@nxp.com>
 <20161207005904.GA12811@home.buserror.net>
In-Reply-To: <20161207005904.GA12811@home.buserror.net>
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

> From: Scott Wood [mailto:oss@buserror.net]
> Sent: Wednesday, December 07, 2016 2:59 AM
>=20
> On Tue, Dec 06, 2016 at 03:13:38PM +0200, Madalin Bucur wrote:
> > Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
> > ---
> >  arch/powerpc/boot/dts/fsl/t1024qds.dts | 29
> +++++++++++++++++++++++++++++
> >  arch/powerpc/boot/dts/fsl/t1024rdb.dts | 33
> +++++++++++++++++++++++++++++++++
> >  2 files changed, 62 insertions(+)
>=20
> So, in patch 1/3 you add qman and bman nodes to t1023si-post.dtsi and
> call it "add QMan and BMan portal nodes on t1023rdb" as if it were
> board-specific (the only board-specific part is the reserved-memory
> nodes, not the portals).
>=20
> Then, in this patch you only touch board-specific files, and label it
> "add QMan and BMan portal nodes on t1024"...

That needs fixing...

> > diff --git a/arch/powerpc/boot/dts/fsl/t1024rdb.dts
> b/arch/powerpc/boot/dts/fsl/t1024rdb.dts
> > index 302cdd2..73a6453 100644
> > --- a/arch/powerpc/boot/dts/fsl/t1024rdb.dts
> > +++ b/arch/powerpc/boot/dts/fsl/t1024rdb.dts
> > @@ -41,6 +41,31 @@
> >  	#size-cells =3D <2>;
> >  	interrupt-parent =3D <&mpic>;
> >
> > +	aliases {
> > +		sg_2500_aqr105_phy4 =3D &sg_2500_aqr105_phy4;
> > +	};
>=20
> What does this have to do with the qman and bman portal nodes?  Why is
> this alias needed?
>=20
> -Scott

It's needed by u-boot, should be a separate patch.
I'll resend.

Madalin
