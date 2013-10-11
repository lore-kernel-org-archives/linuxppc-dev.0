Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E2AC02C0199
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Oct 2013 06:07:26 +1100 (EST)
Message-ID: <1381518433.7979.536.camel@snotra.buserror.net>
Subject: Re: [PATCH v5] powerpc/mpc85xx: Update the clock nodes in device tree
From: Scott Wood <scottwood@freescale.com>
To: Mark Rutland <mark.rutland@arm.com>
Date: Fri, 11 Oct 2013 14:07:13 -0500
In-Reply-To: <20131011092526.GE3910@e106331-lin.cambridge.arm.com>
References: <1381300704-4238-1-git-send-email-Yuantian.Tang@freescale.com>
 <20131010100331.GE26954@e106331-lin.cambridge.arm.com>
 <D07C73A334FF604B95B3CBD2A545D07B150BD137@039-SN2MPN1-013.039d.mgd.msft.net>
 <20131011092526.GE3910@e106331-lin.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Tang Yuantian-B29983 <B29983@freescale.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-Leo-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-10-11 at 10:25 +0100, Mark Rutland wrote:
> On Fri, Oct 11, 2013 at 04:18:18AM +0100, Tang Yuantian-B29983 wrote:
> > Thanks for your review.
> > See my reply inline
> >
> > > -----Original Message-----
> > > From: Mark Rutland [mailto:mark.rutland@arm.com]
> > > Sent: 2013=E5=B9=B410=E6=9C=8810=E6=97=A5 =E6=98=9F=E6=9C=9F=E5=9B=9B=
 18:04
> > > To: Tang Yuantian-B29983
> > > Cc: galak@kernel.crashing.org; linuxppc-dev@lists.ozlabs.org;
> > > devicetree@vger.kernel.org; Li Yang-Leo-R58472
> > > Subject: Re: [PATCH v5] powerpc/mpc85xx: Update the clock nodes in =
device
> > > tree
> > >
> > > On Wed, Oct 09, 2013 at 07:38:24AM +0100, Yuantian.Tang@freescale.c=
om
> > > wrote:
> > > > From: Tang Yuantian <yuantian.tang@freescale.com>
> > > >
> > > > The following SoCs will be affected: p2041, p3041, p4080, p5020,
> > > > p5040, b4420, b4860, t4240
> > > >
> > > > Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> > > > Signed-off-by: Li Yang <leoli@freescale.com>
> > > > ---
> > > > v5:
> > > >         - refine the binding document
> > > >         - update the compatible string
> > > > v4:
> > > >         - add binding document
> > > >         - update compatible string
> > > >         - update the reg property
> > > > v3:
> > > >         - fix typo
> > > > v2:
> > > >         - add t4240, b4420, b4860 support
> > > >         - remove pll/4 clock from p2041, p3041 and p5020 board
> > > >
> > > >  .../devicetree/bindings/clock/corenet-clock.txt    | 111
> > > ++++++++++++++++++++
> > > >  arch/powerpc/boot/dts/fsl/b4420si-post.dtsi        |  35 +++++++
> > > >  arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi         |   2 +
> > > >  arch/powerpc/boot/dts/fsl/b4860si-post.dtsi        |  35 +++++++
> > > >  arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi         |   4 +
> > > >  arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |  60 +++++++=
++++
> > > >  arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi         |   4 +
> > > >  arch/powerpc/boot/dts/fsl/p3041si-post.dtsi        |  60 +++++++=
++++
> > > >  arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi         |   4 +
> > > >  arch/powerpc/boot/dts/fsl/p4080si-post.dtsi        | 112
> > > +++++++++++++++++++++
> > > >  arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi         |   8 ++
> > > >  arch/powerpc/boot/dts/fsl/p5020si-post.dtsi        |  42 +++++++=
+
> > > >  arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi         |   2 +
> > > >  arch/powerpc/boot/dts/fsl/p5040si-post.dtsi        |  60 +++++++=
++++
> > > >  arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi         |   4 +
> > > >  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        |  85
> > > ++++++++++++++++
> > > >  arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi         |  12 +++
> > > >  17 files changed, 640 insertions(+)
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/clock/corenet-clock.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/clock/corenet-cloc=
k.txt
> > > > b/Documentation/devicetree/bindings/clock/corenet-clock.txt
> > > > new file mode 100644
> > > > index 0000000..8efc62d
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/clock/corenet-clock.txt
> > > > @@ -0,0 +1,111 @@
> > > > +* Clock Block on Freescale CoreNet Platforms
> > > > +
> > > > +Freescale CoreNet chips take primary clocking input from the ext=
ernal
> > > > +SYSCLK signal. The SYSCLK input (frequency) is multiplied using
> > > > +multiple phase locked loops (PLL) to create a variety of frequen=
cies
> > > > +which can then be passed to a variety of internal logic, includi=
ng
> > > > +cores and peripheral IP blocks.
> > > > +Please refer to the Reference Manual for details.
> > > > +
> > > > +1. Clock Block Binding
> > > > +
> > > > +Required properties:
> > > > +- compatible: Should include one or more of the following:
> > > > +       - "fsl,<chip>-clockgen": for chip specific clock block
> > > > +       - "fsl,qoriq-clockgen-[1,2].x": for chassis 1.x and 2.x c=
lock
> > >
> > > While I can see that "fsl,<chip>-clockgen" might have a large set o=
f
> > > strings that we may never deal with in th kernel, I'd prefer that t=
he
> > > basic strings (i.e. all the "fsl,qoriq-clockgen-[1,2].x" variants) =
were
> > > listed explicitly here.
> > >
> > > Given they only seem to be "fsl,qoriq-clockgen-1.0" and "fsl,qoriq-
> > > clockgen-2.0" this shouldn't be too difficult to list and describe.
> > >
> > OK, I will list them all.
>=20
> Thanks.
>=20
> >
> > > > +- reg: Offset and length of the clock register set
> > > > +- clock-frequency: Indicates input clock frequency of clock bloc=
k.
> > > > +       Will be set by u-boot
> > >
> > > Why does the fact this is set by u-boot matter to the binding?
> > >
> > OK, I will remove it.
> >
> > > > +
> > > > +Recommended properties:
> > > > +- #ddress-cells: Specifies the number of cells used to represent
> > > > +       physical base addresses.  Must be present if the device h=
as
> > > > +       sub-nodes and set to 1 if present
> > >
> > > Typo: #address-cells
> > >
> > > In the example it looks like the address cells of child nodes are o=
ffsets
> > > within the unit, rather than absolute physical addresses. Could the=
 code
> > > not treat them as absolute addresses? Then we'd only need to docume=
nt
> > > that #address-cells, #size-cells and ranges must be present and hav=
e
> > > values suitable for mapping child nodes into the address space of t=
he
> > > parent.
> > >
> > OK, thanks.
> >
> > > > +- #size-cells: Specifies the number of cells used to represent
> > > > +       the size of an address. Must be present if the device has
> > > > +       sub-nodes and set to 1 if present
> > >
> > > It's not really the size of an address, it's the size of a region
> > > identified by a reg entry.
> > >
> > > I think this can be simplified by my suggestion above.
> > >
> > Yes
>=20
> Aah, I see that this is already in use, so it's a bit late to change
> this...
>=20
> >
> > > > +
> > > > +2. Clock Provider/Consumer Binding
> > > > +
> > > > +Most of the binding are from the common clock binding[1].
> > > > + [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> > > > +
> > > > +Required properties:
> > > > +- compatible : Should include one or more of the following:
>=20
> I didn't spot this earlier, but why "one or more"? are the 2.0 variants
> backwards compatible with the 1.0 variants.
>=20
> > > > +       - "fsl,qoriq-core-pll-[1,2].x": Indicates a core PLL cloc=
k
> > > device
> > > > +       - "fsl,qoriq-core-mux-[1,2].x": Indicates a core multiple=
xer
> > > clock
> > > > +               device; divided from the core PLL clock
> > >
> > > As above, I'd prefer a complete list of the basic strings we expect=
.
> > >
> > There is no list here, just *-mux-1.x and *-mux-2.x
> > What kind of list do you prefer?
>=20
> Something like:
>=20
> - compatible: Should include at least one of:
>     * "fsl,qoriq-core-pll-1.0" for core PLL clocks (v1.0)
>     * "fsl,qoriq-core-pll-2.0" for core PLL clocks (v2.0)
>     * "fsl,qoriq-core-mux-1.0" for core mux clocks (v1.0)
>     * "fsl,qoriq-core-mux-2.0" for core mux clocks (v2.0)
>   The *-2.0 variants are backwards compatible with the *-1.0 variants,
>   so for compatiblity a *-1.0 variant string should be in the list.

I'm not sure that they're 100% compatible.  1.0 seems to have a "KILL"
bit in the PLL register that 2.0 doesn't have (unless it's a
documentation glitch).

> > > > +- clock-output-names: From common clock binding, indicates the n=
ames
> > > of
> > > > +       output clocks
> > > > +- reg: Should be the offset and length of clock block base addre=
ss.
> > > > +       The length should be 4.
> > > > +
> > > > +Example for clock block and clock provider:
> > > > +/ {
> > > > +       clockgen: global-utilities@e1000 {
> > > > +               compatible =3D "fsl,p5020-clockgen", "fsl,qoriq-c=
lockgen-
> > > 1.0";
> > > > +               reg =3D <0xe1000 0x1000>;
> > > > +               clock-frequency =3D <0>;
> > >
> > > That looks odd.
> > >
> > Yes, but it has already existed here before this patch.
> > Can I move it to sysclk clock node since it is not used yet?
>=20
> I hadn't realised there were DTS with this already. Why is there a cloc=
k
> with clock-frequency =3D <0> at all? Surely that isn't useful...

The actual frequency is patched in by U-Boot -- and moving it to a
different node would break this.

> > > > +               #address-cells =3D <1>;
> > > > +               #size-cells =3D <1>;
> > > > +
> > > > +               sysclk: sysclk {
> > > > +                       #clock-cells =3D <0>;
> > > > +                       compatible =3D "fsl,qoriq-sysclk-1.0",
> > > > + "fixed-clock";
> > >
> > > We didn't mention in the binding that "fsl,qoriq-sysclk-1.0" was
> > > compatible with "fixed-clock" and should have "fixed-clock" in the
> > > compatible list...
> > >
> > OK, will fix it.
>=20
> Cheers. Also, doesn't a fixed-clock require a clock-frequency?

Why isn't the global-utilities node, that has the clock-frequency,
acting as the fixed-clock?  I thought that's what was in earlier
revisions...

If it absolutely must be a separate node for some reason, I suppose you
could remove the "fixed-clock" and have a tiny "driver" that looks up
the frequency in the parent node.  This would be an instance of a
non-"fixed-clock" that doesn't have a parent clock described in the
device tree, because the information comes from some other mechanism.

> > > > +               mux1: mux1@20 {
> > > > +                       #clock-cells =3D <0>;
> > > > +                       reg =3D <0x20 0x4>;
> > > > +                       compatible =3D "fsl,qoriq-core-mux-1.0";
> > > > +                       clocks =3D <&pll0 0>, <&pll0 1>, <&pll1 0=
>,
> > > <&pll1 1>;
> > > > +                       clock-names =3D "pll0_0", "pll0_1", "pll1=
_0",
> > > "pll1_1";
>=20
> I didn't spot this last time, but the clock-names here seem to be the
> names of the outputs from the provider, rather than the input names of
> the consumer. This goes against the intended purpose of clock-names.

As far as "pll0", "pll1", etc. goes, that appears to be the input name.
It's all on one chip, so the virtual pins are documented based on what
they're connected to.

I'm not sure I understand the "_0"/"_1" part, though.  Doesn't each PLL
just have one output, which the consumer may choose to divide by 2 (or
in some cases 4)?  Why does that division need to be exposed in the
device tree as separate connections to the parent clock?

-Scott
