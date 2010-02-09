Return-Path: <John.Linn@xilinx.com>
Received: from SG2EHSOBE002.bigfish.com (sg2ehsobe002.messaging.microsoft.com
	[207.46.51.76]) by ozlabs.org (Postfix) with ESMTP id B8783B7D0D
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 02:57:58 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: [PATCH] [V2] net: emaclite: adding MDIO and phy lib support
Date: Tue, 9 Feb 2010 08:57:10 -0700
In-Reply-To: <fa686aa41002090745x19d569acx3b50e8078ebb16f7@mail.gmail.com>
References: <1265409646-11882-1-git-send-email-john.linn@xilinx.com>
	<260b8801-53bd-44fe-a6b8-7d1d0f56fef5@SG2EHSMHS011.ehs.local>
	<fa686aa41002090745x19d569acx3b50e8078ebb16f7@mail.gmail.com>
From: John Linn <John.Linn@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-ID: <7a99fdf2-8fd0-4fd0-9cbb-fe6c87d5f50e@SG2EHSMHS015.ehs.local>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Sadanand Mutyala <sadanan@xilinx.com>, jgarzik@pobox.com,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of Gra=
nt Likely
> Sent: Tuesday, February 09, 2010 8:45 AM
> To: John Linn
> Cc: netdev@vger.kernel.org; linuxppc-dev@ozlabs.org; jgarzik@pobox.com; j=
wboyer@linux.vnet.ibm.com;
> john.williams@petalogix.com; Sadanand Mutyala
> Subject: Re: [PATCH] [V2] net: emaclite: adding MDIO and phy lib support
> =

> On Mon, Feb 8, 2010 at 7:09 AM, John Linn <John.Linn@xilinx.com> wrote:
> >> -----Original Message-----
> >> From: John Linn [mailto:john.linn@xilinx.com]
> >> Sent: Friday, February 05, 2010 3:41 PM
> >> To: netdev@vger.kernel.org; linuxppc-dev@ozlabs.org;
> > jgarzik@pobox.com; grant.likely@secretlab.ca;
> >> jwboyer@linux.vnet.ibm.com
> >> Cc: john.williams@petalogix.com; John Linn; Sadanand Mutyala
> >> Subject: [PATCH] [V2] net: emaclite: adding MDIO and phy lib support
> >>
> >> These changes add MDIO and phy lib support to the driver as the
> >> IP core now supports the MDIO bus.
> >>
> >> The MDIO bus and phy are added as a child to the emaclite in the
> > device
> >> tree as illustrated below.
> >>
> >> mdio {
> >> =A0 =A0 =A0 #address-cells =3D <1>;
> >> =A0 =A0 =A0 #size-cells =3D <0>;
> >> =A0 =A0 =A0 compatible =3D "xlnx,emaclite-mdio";
> >> =A0 =A0 =A0 phy0: phy@7 {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <7>;
> >> =A0 =A0 =A0 } ;
> >> }
> =

> You misunderstood me about the compatible property.  You don't need a
> compatible prop in the mdio node because it is *alwasy* a child of the
> emaclite node, and the emaclite driver knows to go looking for it (ie.
> it is a part of the device).

OK, now I see, sorry for my denseness there.

> =

> What I want to see is a compatible value in the phy@7 node for the
> make & model of the phy.

Makes more sense.

> =

> Otherwise, looks good to me.  Fix the mutex timeout problem and then
> you can add my acked-by line to the patch.

Will spin V3 patch with fixes and add your ack, appreciate the help and you=
r patience.

- John

> =

> Cheers,
> g.


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
