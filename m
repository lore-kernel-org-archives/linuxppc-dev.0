Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A93752C008F
 for <linuxppc-dev@ozlabs.org>; Thu,  1 Aug 2013 01:47:52 +1000 (EST)
Date: Wed, 31 Jul 2013 10:46:54 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3 2/3] powerpc/85xx: Add silicon device tree for C293
To: Liu Po-B43644 <B43644@freescale.com>
References: <1374806479-812-3-git-send-email-Po.Liu@freescale.com>
 <1375174163-19246-1-git-send-email-Po.Liu@freescale.com>
 <1375174163-19246-2-git-send-email-Po.Liu@freescale.com>
 <1375208891.30721.74@snotra>
 <D473A0D087F4EA47A30C37E4637E25E609DB5966@039-SN2MPN1-023.039d.mgd.msft.net>
In-Reply-To: <D473A0D087F4EA47A30C37E4637E25E609DB5966@039-SN2MPN1-023.039d.mgd.msft.net>
 (from B43644@freescale.com on Tue Jul 30 21:13:28 2013)
Message-ID: <1375285614.30721.90@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Hu Mingkai-B21284 <B21284@freescale.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/30/2013 09:13:28 PM, Liu Po-B43644 wrote:
>=20
> >  -----Original Message-----
> >  From: Wood Scott-B07421
> >  Sent: Wednesday, July 31, 2013 2:28 AM
> >  To: Liu Po-B43644
> >  Cc: linuxppc-dev@ozlabs.org; galak@kernel.crashing.org; Fleming =20
> Andy-
> >  AFLEMING; Hu Mingkai-B21284; Liu Po-B43644
> >  Subject: Re: [PATCH v3 2/3] powerpc/85xx: Add silicon device tree =20
> for
> >  C293
> >
> >  On 07/30/2013 03:49:22 AM, Po Liu wrote:
> >  > +	crypto@80000 {
> >  > +/include/ "qoriq-sec6.0-0.dtsi"
> >  > +	};
> >  > +
> >  > +	crypto@80000 {
> >  > +		reg =3D <0x80000 0x20000>;
> >  > +		ranges =3D <0x0 0x80000 0x20000>;
> >  > +
> >  > +		jr@1000{
> >  > +			interrupts =3D <45 2 0 0>;
> >  > +		};
> >  > +		jr@2000{
> >  > +			interrupts =3D <57 2 0 0>;
> >  > +		};
> >  > +	};
> >
> >  Do these inline the way the example shows.
> Sorry, Scott, I just remember in this way, the node can't be =20
> recognized by system when run Uboot. The include can't be in the =20
> crypto@80000. See the discussion in =20
> http://git.am.freescale.net:8181/#/c/736/  .
> Maybe I should re-modify the example file.

git.am.freescale.net is not accessible outside of Freescale; don't =20
reference it on external lists.  In any case, I don't know what =20
specifically you want me to look at there.  Just put the explanation =20
here.

I do not expect the dtc output to be any different between the two =20
methods.  Could you check this (by using dtc to decompile the dtb =20
afterward) and point out exactly how the output differs between the two =20
approaches?

-Scott=
