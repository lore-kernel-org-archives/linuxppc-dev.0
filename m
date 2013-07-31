Return-Path: <B43644@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CAFAF2C00C9
 for <linuxppc-dev@ozlabs.org>; Wed, 31 Jul 2013 12:13:35 +1000 (EST)
From: Liu Po-B43644 <B43644@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH v3 2/3] powerpc/85xx: Add silicon device tree for C293
Date: Wed, 31 Jul 2013 02:13:28 +0000
Message-ID: <D473A0D087F4EA47A30C37E4637E25E609DB5966@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1374806479-812-3-git-send-email-Po.Liu@freescale.com>
 <1375174163-19246-1-git-send-email-Po.Liu@freescale.com>
 <1375174163-19246-2-git-send-email-Po.Liu@freescale.com>
 <1375208891.30721.74@snotra>
In-Reply-To: <1375208891.30721.74@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Hu Mingkai-B21284 <B21284@freescale.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>  -----Original Message-----
>  From: Wood Scott-B07421
>  Sent: Wednesday, July 31, 2013 2:28 AM
>  To: Liu Po-B43644
>  Cc: linuxppc-dev@ozlabs.org; galak@kernel.crashing.org; Fleming Andy-
>  AFLEMING; Hu Mingkai-B21284; Liu Po-B43644
>  Subject: Re: [PATCH v3 2/3] powerpc/85xx: Add silicon device tree for
>  C293
> =20
>  On 07/30/2013 03:49:22 AM, Po Liu wrote:
>  > From: Mingkai Hu <Mingkai.Hu@freescale.com>
>  >
>  > Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
>  > Signed-off-by: Po Liu <Po.Liu@freescale.com>
>  > ---
>  > Changes for v2:
>  > 	- None
>  > Changes for v3:
>  > 	- None
>  >
>  >  arch/powerpc/boot/dts/fsl/c293si-post.dtsi | 193
>  > +++++++++++++++++++++++++++++
>  >  arch/powerpc/boot/dts/fsl/c293si-pre.dtsi  |  63 ++++++++++
>  >  2 files changed, 256 insertions(+)
>  >  create mode 100644 arch/powerpc/boot/dts/fsl/c293si-post.dtsi
>  >  create mode 100644 arch/powerpc/boot/dts/fsl/c293si-pre.dtsi
>  >
>  > diff --git a/arch/powerpc/boot/dts/fsl/c293si-post.dtsi
>  > b/arch/powerpc/boot/dts/fsl/c293si-post.dtsi
>  > new file mode 100644
>  > index 0000000..bd20832
>  > --- /dev/null
>  > +++ b/arch/powerpc/boot/dts/fsl/c293si-post.dtsi
>  > @@ -0,0 +1,193 @@
>  > +/*
>  > + * C293 Silicon/SoC Device Tree Source (post include)
>  > + *
>  > + * Copyright 2012 Freescale Semiconductor Inc.
>  > + *
>  > + * Redistribution and use in source and binary forms, with or without
>  > + * modification, are permitted provided that the following
>  > conditions are met:
>  > + *     * Redistributions of source code must retain the above
>  > copyright
>  > + *       notice, this list of conditions and the following
>  > disclaimer.
>  > + *     * Redistributions in binary form must reproduce the above
>  > copyright
>  > + *       notice, this list of conditions and the following
>  > disclaimer in the
>  > + *       documentation and/or other materials provided with the
>  > distribution.
>  > + *     * Neither the name of Freescale Semiconductor nor the
>  > + *       names of its contributors may be used to endorse or promote
>  > products
>  > + *       derived from this software without specific prior written
>  > permission.
>  > + *
>  > + *
>  > + * ALTERNATIVELY, this software may be distributed under the terms
>  > of the
>  > + * GNU General Public License ("GPL") as published by the Free
>  > Software
>  > + * Foundation, either version 2 of that License or (at your option)
>  > any
>  > + * later version.
>  > + *
>  > + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS''
>  > AND ANY
>  > + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
>  > IMPLIED
>  > + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
>  > PURPOSE ARE
>  > + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE
>  > FOR ANY
>  > + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
>  > CONSEQUENTIAL DAMAGES
>  > + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
>  > OR SERVICES;
>  > + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
>  > CAUSED AND
>  > + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
>  > LIABILITY, OR TORT
>  > + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
>  > USE OF THIS
>  > + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>  > + */
>  > +
>  > +&ifc {
>  > +	#address-cells =3D <2>;
>  > +	#size-cells =3D <1>;
>  > +	compatible =3D "fsl,ifc", "simple-bus";
>  > +	interrupts =3D <19 2 0 0>;
>  > +};
>  > +
>  > +/* controller at 0xa000 */
>  > +&pci0 {
>  > +	compatible =3D "fsl,qoriq-pcie-v2.2", "fsl,qoriq-pcie";
>  > +	device_type =3D "pci";
>  > +	#size-cells =3D <2>;
>  > +	#address-cells =3D <3>;
>  > +	bus-range =3D <0 255>;
>  > +	clock-frequency =3D <33333333>;
>  > +	interrupts =3D <16 2 0 0>;
> =20
>  Remove clock-frequency (surely PCIe is not running at 33 MHz).
> =20
>  > +	crypto@80000 {
>  > +/include/ "qoriq-sec6.0-0.dtsi"
>  > +	};
>  > +
>  > +	crypto@80000 {
>  > +		reg =3D <0x80000 0x20000>;
>  > +		ranges =3D <0x0 0x80000 0x20000>;
>  > +
>  > +		jr@1000{
>  > +			interrupts =3D <45 2 0 0>;
>  > +		};
>  > +		jr@2000{
>  > +			interrupts =3D <57 2 0 0>;
>  > +		};
>  > +	};
> =20
>  Do these inline the way the example shows.
Sorry, Scott, I just remember in this way, the node can't be recognized by =
system when run Uboot. The include can't be in the crypto@80000. See the di=
scussion in http://git.am.freescale.net:8181/#/c/736/  .
Maybe I should re-modify the example file.
> =20
>  -Scott
