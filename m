Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.225])
	by ozlabs.org (Postfix) with ESMTP id 05D38DE130
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 01:42:46 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f9so2604538rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 08:42:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1239810033-8213-1-git-send-email-galak@kernel.crashing.org>
References: <1239810033-8213-1-git-send-email-galak@kernel.crashing.org>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 15 Apr 2009 09:42:29 -0600
Message-ID: <fa686aa40904150842w3edb6767qcc6fa81f8b6c2e12@mail.gmail.com>
Subject: Re: [PATCH] powerpc/fsl: Remove cell-index from PCI nodes
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 15, 2009 at 9:40 AM, Kumar Gala <galak@kernel.crashing.org> wro=
te:
> The cell-index property isn't used on PCI nodes and is ill defined.
> Remove it for now and if someone comes up with a good reason and
> consistent definition for it we can add it back
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0arch/powerpc/boot/dts/mpc832x_mds.dts =A0 =A0 =A0 =A0 =A0| =A0 =A01 -
> =A0arch/powerpc/boot/dts/mpc832x_rdb.dts =A0 =A0 =A0 =A0 =A0| =A0 =A01 -
> =A0arch/powerpc/boot/dts/mpc8349emitx.dts =A0 =A0 =A0 =A0 | =A0 =A02 --
> =A0arch/powerpc/boot/dts/mpc8349emitxgp.dts =A0 =A0 =A0 | =A0 =A01 -
> =A0arch/powerpc/boot/dts/mpc834x_mds.dts =A0 =A0 =A0 =A0 =A0| =A0 =A02 --
> =A0arch/powerpc/boot/dts/mpc836x_mds.dts =A0 =A0 =A0 =A0 =A0| =A0 =A01 -
> =A0arch/powerpc/boot/dts/mpc8377_mds.dts =A0 =A0 =A0 =A0 =A0| =A0 =A01 -
> =A0arch/powerpc/boot/dts/mpc8378_mds.dts =A0 =A0 =A0 =A0 =A0| =A0 =A01 -
> =A0arch/powerpc/boot/dts/mpc8379_mds.dts =A0 =A0 =A0 =A0 =A0| =A0 =A01 -
> =A0arch/powerpc/boot/dts/mpc8536ds.dts =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04 =
----
> =A0arch/powerpc/boot/dts/mpc8540ads.dts =A0 =A0 =A0 =A0 =A0 | =A0 =A01 -
> =A0arch/powerpc/boot/dts/mpc8541cds.dts =A0 =A0 =A0 =A0 =A0 | =A0 =A02 --
> =A0arch/powerpc/boot/dts/mpc8544ds.dts =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04 =
----
> =A0arch/powerpc/boot/dts/mpc8548cds.dts =A0 =A0 =A0 =A0 =A0 | =A0 =A03 --=
-
> =A0arch/powerpc/boot/dts/mpc8555cds.dts =A0 =A0 =A0 =A0 =A0 | =A0 =A02 --
> =A0arch/powerpc/boot/dts/mpc8560ads.dts =A0 =A0 =A0 =A0 =A0 | =A0 =A01 -
> =A0arch/powerpc/boot/dts/mpc8568mds.dts =A0 =A0 =A0 =A0 =A0 | =A0 =A02 --
> =A0arch/powerpc/boot/dts/mpc8572ds.dts =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A03 =
---
> =A0arch/powerpc/boot/dts/mpc8572ds_36b.dts =A0 =A0 =A0 =A0| =A0 =A03 ---
> =A0arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts | =A0 =A02 --
> =A0arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts | =A0 =A01 -
> =A0arch/powerpc/boot/dts/mpc8610_hpcd.dts =A0 =A0 =A0 =A0 | =A0 =A02 --
> =A0arch/powerpc/boot/dts/mpc8641_hpcn.dts =A0 =A0 =A0 =A0 | =A0 =A02 --
> =A0arch/powerpc/boot/dts/sbc8349.dts =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
1 -
> =A0arch/powerpc/boot/dts/sbc8548.dts =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2 --
> =A0arch/powerpc/boot/dts/sbc8560.dts =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
1 -
> =A0arch/powerpc/boot/dts/sbc8641d.dts =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 =
--
> =A0arch/powerpc/boot/dts/socrates.dts =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 =
-
> =A0arch/powerpc/boot/dts/stx_gp3_8560.dts =A0 =A0 =A0 =A0 | =A0 =A01 -
> =A0arch/powerpc/boot/dts/tqm8540.dts =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
1 -
> =A0arch/powerpc/boot/dts/tqm8541.dts =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
1 -
> =A0arch/powerpc/boot/dts/tqm8548-bigflash.dts =A0 =A0 | =A0 =A02 --
> =A0arch/powerpc/boot/dts/tqm8548.dts =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2 --
> =A0arch/powerpc/boot/dts/tqm8555.dts =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
1 -
> =A0arch/powerpc/boot/dts/tqm8560.dts =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
1 -
> =A035 files changed, 0 insertions(+), 59 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dt=
s/mpc832x_mds.dts
> index 57c595b..6b319f5 100644
> --- a/arch/powerpc/boot/dts/mpc832x_mds.dts
> +++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
> @@ -369,7 +369,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pci@e0008500 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0xf800 0x0 0x0 0x7=
>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D <
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* IDSEL 0=
x11 AD17 */
> diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dt=
s/mpc832x_rdb.dts
> index 4319bd7..4c0c249 100644
> --- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
> +++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
> @@ -327,7 +327,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pci@e0008500 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0xf800 0x0 0x0 0x7=
>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D <
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* IDSEL 0=
x10 AD16 (USB) */
> diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/d=
ts/mpc8349emitx.dts
> index 1ae38f0..e3eeaed 100644
> --- a/arch/powerpc/boot/dts/mpc8349emitx.dts
> +++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
> @@ -278,7 +278,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pci@e0008500 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0xf800 0x0 0x0 0x7=
>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D <
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* IDSEL 0=
x10 - SATA */
> @@ -301,7 +300,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci1: pci@e0008600 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0xf800 0x0 0x0 0x7=
>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D <
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* IDSEL 0=
x0E - MiniPCI Slot */
> diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot=
/dts/mpc8349emitxgp.dts
> index 662abe1..eb73211 100644
> --- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
> +++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
> @@ -227,7 +227,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pci@e0008600 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0xf800 0x0 0x0 0x7=
>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D <
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* IDSEL 0=
x0F - PCI Slot */
> diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dt=
s/mpc834x_mds.dts
> index d9f0a23..a2553a6 100644
> --- a/arch/powerpc/boot/dts/mpc834x_mds.dts
> +++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
> @@ -286,7 +286,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pci@e0008500 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0xf800 0x0 0x0 0x7=
>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D <
>
> @@ -348,7 +347,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci1: pci@e0008600 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0xf800 0x0 0x0 0x7=
>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D <
>
> diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dt=
s/mpc836x_mds.dts
> index 6e34f17..1207ec8 100644
> --- a/arch/powerpc/boot/dts/mpc836x_mds.dts
> +++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
> @@ -410,7 +410,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pci@e0008500 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0xf800 0x0 0x0 0x7=
>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D <
>
> diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dt=
s/mpc8377_mds.dts
> index 9637080..67bb372 100644
> --- a/arch/powerpc/boot/dts/mpc8377_mds.dts
> +++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
> @@ -383,7 +383,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pci@e0008500 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0xf800 0x0 0x0 0x7=
>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D <
>
> diff --git a/arch/powerpc/boot/dts/mpc8378_mds.dts b/arch/powerpc/boot/dt=
s/mpc8378_mds.dts
> index 651ff2f..a955a57 100644
> --- a/arch/powerpc/boot/dts/mpc8378_mds.dts
> +++ b/arch/powerpc/boot/dts/mpc8378_mds.dts
> @@ -367,7 +367,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pci@e0008500 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0xf800 0x0 0x0 0x7=
>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D <
>
> diff --git a/arch/powerpc/boot/dts/mpc8379_mds.dts b/arch/powerpc/boot/dt=
s/mpc8379_mds.dts
> index d6f208b..d266ddb 100644
> --- a/arch/powerpc/boot/dts/mpc8379_mds.dts
> +++ b/arch/powerpc/boot/dts/mpc8379_mds.dts
> @@ -397,7 +397,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pci@e0008500 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0xf800 0x0 0x0 0x7=
>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D <
>
> diff --git a/arch/powerpc/boot/dts/mpc8536ds.dts b/arch/powerpc/boot/dts/=
mpc8536ds.dts
> index b31c504..af8c64c 100644
> --- a/arch/powerpc/boot/dts/mpc8536ds.dts
> +++ b/arch/powerpc/boot/dts/mpc8536ds.dts
> @@ -321,7 +321,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pci@ffe08000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8540-pci";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "pci";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0xf800 0x0 0x0 0x7=
>;
> @@ -346,7 +345,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci1: pcie@ffe09000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8548-pcie";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "pci";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> @@ -383,7 +381,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci2: pcie@ffe0a000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8548-pcie";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "pci";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> @@ -420,7 +417,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci3: pcie@ffe0b000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <3>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8548-pcie";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "pci";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts=
/mpc8540ads.dts
> index ddd67be..de5535c 100644
> --- a/arch/powerpc/boot/dts/mpc8540ads.dts
> +++ b/arch/powerpc/boot/dts/mpc8540ads.dts
> @@ -258,7 +258,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pci@e0008000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0xf800 0x0 0x0 0x7=
>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D <
>
> diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/boot/dts=
/mpc8541cds.dts
> index e45097f..d10f5d6 100644
> --- a/arch/powerpc/boot/dts/mpc8541cds.dts
> +++ b/arch/powerpc/boot/dts/mpc8541cds.dts
> @@ -272,7 +272,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pci@e0008000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0x1f800 0x0 0x0 0x=
7>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D <
>
> @@ -344,7 +343,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci1: pci@e0009000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0xf800 0x0 0x0 0x7=
>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D <
>
> diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/=
mpc8544ds.dts
> index 7c6932b..3ae31d7 100644
> --- a/arch/powerpc/boot/dts/mpc8544ds.dts
> +++ b/arch/powerpc/boot/dts/mpc8544ds.dts
> @@ -274,7 +274,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pci@e0008000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8540-pci";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "pci";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0xf800 0x0 0x0 0x7=
>;
> @@ -306,7 +305,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci1: pcie@e0009000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8548-pcie";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "pci";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> @@ -343,7 +341,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci2: pcie@e000a000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8548-pcie";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "pci";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> @@ -380,7 +377,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci3: pcie@e000b000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <3>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8548-pcie";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "pci";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts=
/mpc8548cds.dts
> index 804e903..732c111 100644
> --- a/arch/powerpc/boot/dts/mpc8548cds.dts
> +++ b/arch/powerpc/boot/dts/mpc8548cds.dts
> @@ -328,7 +328,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pci@e0008000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0xf800 0x0 0x0 0x7=
>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D <
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* IDSEL 0x4 (PCIX Slot 2)=
 */
> @@ -478,7 +477,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci1: pci@e0009000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0xf800 0x0 0x0 0x7=
>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D <
>
> @@ -503,7 +501,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci2: pcie@e000a000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0xf800 0x0 0x0 0x7=
>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D <
>
> diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/boot/dts=
/mpc8555cds.dts
> index 9484f07..7f9e535 100644
> --- a/arch/powerpc/boot/dts/mpc8555cds.dts
> +++ b/arch/powerpc/boot/dts/mpc8555cds.dts
> @@ -272,7 +272,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pci@e0008000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0x1f800 0x0 0x0 0x=
7>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D <
>
> @@ -344,7 +343,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci1: pci@e0009000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0xf800 0x0 0x0 0x7=
>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D <
>
> diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts=
/mpc8560ads.dts
> index cc2acf8..190d46b 100644
> --- a/arch/powerpc/boot/dts/mpc8560ads.dts
> +++ b/arch/powerpc/boot/dts/mpc8560ads.dts
> @@ -291,7 +291,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pci@e0008000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <3>;
> diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts=
/mpc8568mds.dts
> index 9d52e3b..3330356 100644
> --- a/arch/powerpc/boot/dts/mpc8568mds.dts
> +++ b/arch/powerpc/boot/dts/mpc8568mds.dts
> @@ -459,7 +459,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pci@e0008000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0xf800 0x0 0x0 0x7=
>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D <
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* IDSEL 0x12 AD18 */
> @@ -490,7 +489,6 @@
>
> =A0 =A0 =A0 =A0/* PCI Express */
> =A0 =A0 =A0 =A0pci1: pcie@e000a000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0xf800 0x0 0x0 0x7=
>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D <
>
> diff --git a/arch/powerpc/boot/dts/mpc8572ds.dts b/arch/powerpc/boot/dts/=
mpc8572ds.dts
> index 6e79a41..75fc30b 100644
> --- a/arch/powerpc/boot/dts/mpc8572ds.dts
> +++ b/arch/powerpc/boot/dts/mpc8572ds.dts
> @@ -514,7 +514,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pcie@ffe08000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8548-pcie";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "pci";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> @@ -724,7 +723,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci1: pcie@ffe09000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8548-pcie";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "pci";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> @@ -761,7 +759,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci2: pcie@ffe0a000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8548-pcie";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "pci";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> diff --git a/arch/powerpc/boot/dts/mpc8572ds_36b.dts b/arch/powerpc/boot/=
dts/mpc8572ds_36b.dts
> index dbd81a7..e2a1f75 100644
> --- a/arch/powerpc/boot/dts/mpc8572ds_36b.dts
> +++ b/arch/powerpc/boot/dts/mpc8572ds_36b.dts
> @@ -514,7 +514,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pcie@fffe08000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8548-pcie";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "pci";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> @@ -724,7 +723,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci1: pcie@fffe09000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8548-pcie";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "pci";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> @@ -761,7 +759,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci2: pcie@fffe0a000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8548-pcie";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "pci";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> diff --git a/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts b/arch/powerp=
c/boot/dts/mpc8572ds_camp_core0.dts
> index 2bc0c71..45ca89e 100644
> --- a/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
> +++ b/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
> @@ -238,7 +238,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pcie@ffe08000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8548-pcie";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "pci";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> @@ -448,7 +447,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci1: pcie@ffe09000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8548-pcie";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "pci";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> diff --git a/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts b/arch/powerp=
c/boot/dts/mpc8572ds_camp_core1.dts
> index 159cb3a..0ded4a6 100644
> --- a/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
> +++ b/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
> @@ -196,7 +196,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci2: pcie@ffe0a000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8548-pcie";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "pci";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/d=
ts/mpc8610_hpcd.dts
> index 1bd3ebe..4f081bb 100644
> --- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
> +++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
> @@ -316,7 +316,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pci@e0008000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8610-pci";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "pci";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> @@ -346,7 +345,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci1: pcie@e000a000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8641-pcie";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "pci";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/d=
ts/mpc8641_hpcn.dts
> index d72beb1..51852e6 100644
> --- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> +++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> @@ -357,7 +357,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pcie@ffe08000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8641-pcie";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "pci";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> @@ -566,7 +565,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci1: pcie@ffe09000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8641-pcie";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "pci";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> diff --git a/arch/powerpc/boot/dts/sbc8349.dts b/arch/powerpc/boot/dts/sb=
c8349.dts
> index a36dbbc..5fb6f66 100644
> --- a/arch/powerpc/boot/dts/sbc8349.dts
> +++ b/arch/powerpc/boot/dts/sbc8349.dts
> @@ -278,7 +278,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pci@e0008500 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0xf800 0x0 0x0 0x7=
>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D <
>
> diff --git a/arch/powerpc/boot/dts/sbc8548.dts b/arch/powerpc/boot/dts/sb=
c8548.dts
> index b1f1416..196fcc1 100644
> --- a/arch/powerpc/boot/dts/sbc8548.dts
> +++ b/arch/powerpc/boot/dts/sbc8548.dts
> @@ -350,7 +350,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pci@e0008000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0xf800 0x0 0x0 0x7=
>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D <
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* IDSEL 0x01 (PCI-X slot)=
 @66MHz */
> @@ -380,7 +379,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci2: pcie@e000a000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0xf800 0x0 0x0 0x7=
>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D <
>
> diff --git a/arch/powerpc/boot/dts/sbc8560.dts b/arch/powerpc/boot/dts/sb=
c8560.dts
> index c4564b8..813d731 100644
> --- a/arch/powerpc/boot/dts/sbc8560.dts
> +++ b/arch/powerpc/boot/dts/sbc8560.dts
> @@ -296,7 +296,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pci@ff708000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <3>;
> diff --git a/arch/powerpc/boot/dts/sbc8641d.dts b/arch/powerpc/boot/dts/s=
bc8641d.dts
> index e3e914e..cfd5782 100644
> --- a/arch/powerpc/boot/dts/sbc8641d.dts
> +++ b/arch/powerpc/boot/dts/sbc8641d.dts
> @@ -371,7 +371,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pcie@f8008000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8641-pcie";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "pci";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> @@ -410,7 +409,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci1: pcie@f8009000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8641-pcie";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "pci";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> diff --git a/arch/powerpc/boot/dts/socrates.dts b/arch/powerpc/boot/dts/s=
ocrates.dts
> index 7a6ae75..e8f4e46 100644
> --- a/arch/powerpc/boot/dts/socrates.dts
> +++ b/arch/powerpc/boot/dts/socrates.dts
> @@ -314,7 +314,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pci@e0008000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <3>;
> diff --git a/arch/powerpc/boot/dts/stx_gp3_8560.dts b/arch/powerpc/boot/d=
ts/stx_gp3_8560.dts
> index ea6b151..8691dd3 100644
> --- a/arch/powerpc/boot/dts/stx_gp3_8560.dts
> +++ b/arch/powerpc/boot/dts/stx_gp3_8560.dts
> @@ -251,7 +251,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pci@fdf08000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0xf800 0x0 0x0 0x7=
>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D <
>
> diff --git a/arch/powerpc/boot/dts/tqm8540.dts b/arch/powerpc/boot/dts/tq=
m8540.dts
> index b6f1fc6..c8265b6 100644
> --- a/arch/powerpc/boot/dts/tqm8540.dts
> +++ b/arch/powerpc/boot/dts/tqm8540.dts
> @@ -266,7 +266,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pci@e0008000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <3>;
> diff --git a/arch/powerpc/boot/dts/tqm8541.dts b/arch/powerpc/boot/dts/tq=
m8541.dts
> index fa6a3d5..9080546 100644
> --- a/arch/powerpc/boot/dts/tqm8541.dts
> +++ b/arch/powerpc/boot/dts/tqm8541.dts
> @@ -288,7 +288,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pci@e0008000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <3>;
> diff --git a/arch/powerpc/boot/dts/tqm8548-bigflash.dts b/arch/powerpc/bo=
ot/dts/tqm8548-bigflash.dts
> index 00f7ed7..1139eb5 100644
> --- a/arch/powerpc/boot/dts/tqm8548-bigflash.dts
> +++ b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
> @@ -419,7 +419,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pci@a0008000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <3>;
> @@ -441,7 +440,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci1: pcie@a000a000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0xf800 0x0 0x0 0x7=
>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D <
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* IDSEL 0x0 (PEX) */
> diff --git a/arch/powerpc/boot/dts/tqm8548.dts b/arch/powerpc/boot/dts/tq=
m8548.dts
> index 673e4a7..d337d83 100644
> --- a/arch/powerpc/boot/dts/tqm8548.dts
> +++ b/arch/powerpc/boot/dts/tqm8548.dts
> @@ -419,7 +419,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pci@e0008000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <3>;
> @@ -441,7 +440,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci1: pcie@e000a000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map-mask =3D <0xf800 0x0 0x0 0x7=
>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D <
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* IDSEL 0x0 (PEX) */
> diff --git a/arch/powerpc/boot/dts/tqm8555.dts b/arch/powerpc/boot/dts/tq=
m8555.dts
> index 6a99f1e..021039b 100644
> --- a/arch/powerpc/boot/dts/tqm8555.dts
> +++ b/arch/powerpc/boot/dts/tqm8555.dts
> @@ -288,7 +288,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pci@e0008000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <3>;
> diff --git a/arch/powerpc/boot/dts/tqm8560.dts b/arch/powerpc/boot/dts/tq=
m8560.dts
> index b6c2d71..cec84c2 100644
> --- a/arch/powerpc/boot/dts/tqm8560.dts
> +++ b/arch/powerpc/boot/dts/tqm8560.dts
> @@ -359,7 +359,6 @@
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0pci0: pci@e0008000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <3>;
> --
> 1.6.0.6
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
