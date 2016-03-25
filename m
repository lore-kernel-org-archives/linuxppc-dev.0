Return-Path: <yangbo.lu@nxp.com>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1on0083.outbound.protection.outlook.com [157.56.112.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qWYtr3Vw2zDq7K
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Mar 2016 17:54:11 +1100 (AEDT)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: Scott Wood <scott.wood@nxp.com>, Rob Herring <robh@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "linux-i2c@vger.kernel.org"
 <linux-i2c@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-mmc@vger.kernel.org"
 <linux-mmc@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, "Jochen
 Friedrich" <jochen@scram.de>, Joerg Roedel <joro@8bytes.org>, Claudiu Manoil
 <claudiu.manoil@freescale.com>, "ulf.hansson@linaro.org"
 <ulf.hansson@linaro.org>, Bhupesh Sharma <bhupesh.sharma@freescale.com>,
 "Zhao Qiang" <qiang.zhao@freescale.com>, Kumar Gala <galak@codeaurora.org>,
 "Santosh Shilimkar" <ssantosh@kernel.org>, Yang-Leo Li <leoyang.li@nxp.com>,
 Xiaobo Xie <xiaobo.xie@nxp.com>
Subject: RE: [v6, 3/5] dt: move guts devicetree doc out of powerpc directory
Date: Fri, 25 Mar 2016 06:38:16 +0000
Message-ID: <HE1PR04MB08895D48A45AD3F6B32FB088F8830@HE1PR04MB0889.eurprd04.prod.outlook.com>
References: <1457518131-11339-1-git-send-email-yangbo.lu@nxp.com>
 <1457518131-11339-4-git-send-email-yangbo.lu@nxp.com>
 <20160317170640.GB21009@rob-hp-laptop>
 <HE1PR0401MB1931444381E249E41C45C748918C0@HE1PR0401MB1931.eurprd04.prod.outlook.com>
In-Reply-To: <HE1PR0401MB1931444381E249E41C45C748918C0@HE1PR0401MB1931.eurprd04.prod.outlook.com>
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
> From: Scott Wood
> Sent: Saturday, March 19, 2016 2:16 AM
> To: Rob Herring; Yangbo Lu
> Cc: devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; linux-
> clk@vger.kernel.org; linux-i2c@vger.kernel.org; iommu@lists.linux-
> foundation.org; netdev@vger.kernel.org; linux-mmc@vger.kernel.org;
> Russell King; Jochen Friedrich; Joerg Roedel; Claudiu Manoil;
> ulf.hansson@linaro.org; Bhupesh Sharma; Zhao Qiang; Kumar Gala; Santosh
> Shilimkar; Yang-Leo Li; Xiaobo Xie
> Subject: Re: [v6, 3/5] dt: move guts devicetree doc out of powerpc
> directory
>=20
> On 03/17/2016 12:06 PM, Rob Herring wrote:
> > On Wed, Mar 09, 2016 at 06:08:49PM +0800, Yangbo Lu wrote:
> >> Move guts devicetree doc to
> >> Documentation/devicetree/bindings/soc/fsl/
> >> since it's used by not only PowerPC but also ARM. And add a
> >> specification for 'little-endian' property.
> >>
> >> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> >> ---
> >> Changes for v2:
> >> 	- None
> >> Changes for v3:
> >> 	- None
> >> Changes for v4:
> >> 	- Added this patch
> >> Changes for v5:
> >> 	- Modified the description for little-endian property Changes for
> >> v6:
> >> 	- None
> >> ---
> >>  Documentation/devicetree/bindings/{powerpc =3D> soc}/fsl/guts.txt | 3
> >> +++
> >>  1 file changed, 3 insertions(+)
> >>  rename Documentation/devicetree/bindings/{powerpc =3D>
> >> soc}/fsl/guts.txt (91%)
> >>
> >> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
> >> b/Documentation/devicetree/bindings/soc/fsl/guts.txt
> >> similarity index 91%
> >> rename from Documentation/devicetree/bindings/powerpc/fsl/guts.txt
> >> rename to Documentation/devicetree/bindings/soc/fsl/guts.txt
> >> index b71b203..07adca9 100644
> >> --- a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
> >> +++ b/Documentation/devicetree/bindings/soc/fsl/guts.txt
> >> @@ -25,6 +25,9 @@ Recommended properties:
> >>   - fsl,liodn-bits : Indicates the number of defined bits in the LIODN
> >>     registers, for those SOCs that have a PAMU device.
> >>
> >> + - little-endian : Indicates that the global utilities block is
> little
> >> +   endian. The default is big endian.
> >
> > The default is "the native endianness of the system". So absence on an
> > ARM system would be LE.
>=20
> No.  For this binding, the default is big-endian, because that's what
> existed for this device before an endian property was added.
>=20
> "endianness of the system" is not a well-defined concept.
>=20
> > This property is valid for any simple-bus device,
>=20
> Since when does simple-bus mean anything more than that the nodes
> underneath it can be used without bus-specific knowledge?
>=20
> > so it isn't really required to document per device. You can, but your
> > description had better match the documented behaviour.
>=20
> Documented where?
>=20
> In fact, Documentation/devicetree/bindings/common-properties.txt
> explicitly says of the endian properties, "If a binding supports these
> properties, then the binding should also specify the default behavior if
> none of these properties are present."
>=20
> -Scott

[Lu Yangbo-B47093] So, Rob, could you accept this patch after so much discu=
ssion?
:)
