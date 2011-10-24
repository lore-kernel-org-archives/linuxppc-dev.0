Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6AF12B6FA6
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Oct 2011 01:02:06 +1100 (EST)
Subject: Re: [PATCH 03/11] powerpc/85xx: Rework PCI nodes on P1020RDB
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CAOZdJXUy5qDhbEAih2kx91fmgyxqd7u9T6AV4fDvp4AMMRA+4w@mail.gmail.com>
Date: Mon, 24 Oct 2011 09:02:07 -0500
Message-Id: <49F9A823-B7C3-4D53-A061-8AC1C8D22554@kernel.crashing.org>
References: <1319318452-27036-1-git-send-email-galak@kernel.crashing.org>
 <1319318452-27036-2-git-send-email-galak@kernel.crashing.org>
 <1319318452-27036-3-git-send-email-galak@kernel.crashing.org>
 <CAOZdJXUy5qDhbEAih2kx91fmgyxqd7u9T6AV4fDvp4AMMRA+4w@mail.gmail.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 23, 2011, at 9:37 AM, Tabi Timur-B04825 wrote:

> On Sat, Oct 22, 2011 at 4:20 PM, Kumar Gala =
<galak@kernel.crashing.org> wrote:
>> * Move SoC specific details like irq mapping to SoC dtsi
>> * Update interrupt property to cover both error interrupt and PCIe
>>  runtime interrupts
>=20
> Are we going to be doing this for all our device trees?  If so, then I
> think we need to document what properties the board dts should be
> defining when it includes a node from a dtsi.  Something like this:

Yes, I intend we do this as much as possible.

> dtsi:
>               pcie@0 {
>                       /* dts should define 'reg' and 'ranges' */
>                       reg =3D <0 0 0 0 0>;
>                       #interrupt-cells =3D <1>;
>=20
> I suppose it's obvious that 'reg' and 'ranges' should be defined, so
> this isn't the best example.  But we should document if any other
> properties should be defined.
>=20
> For example, the SSI nodes contain a bunch of SOC- and board-specific
> properties.

I would have hoped the bindings had made it clear already what was board =
info vs what was SoC.

If not, they should be clarify that in the binding specs.

- k=
