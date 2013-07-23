Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1E2B12C00BA
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Jul 2013 09:24:25 +1000 (EST)
Received: from mail180-va3 (localhost [127.0.0.1])	by
 mail180-va3-R.bigfish.com (Postfix) with ESMTP id 138F52E00C6	for
 <linuxppc-dev@ozlabs.org>; Tue, 23 Jul 2013 23:24:23 +0000 (UTC)
Received: from VA3EHSMHS024.bigfish.com (unknown [10.7.14.245])	by
 mail180-va3.bigfish.com (Postfix) with ESMTP id 6B40120045	for
 <linuxppc-dev@ozlabs.org>; Tue, 23 Jul 2013 23:24:21 +0000 (UTC)
Date: Tue, 23 Jul 2013 18:24:14 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [1/4] powerpc/85xx: Add SEC6.0 device tree
To: Liu Po-B43644 <B43644@freescale.com>
References: <1366854857-22791-1-git-send-email-Po.Liu@freescale.com>
 <20130722224110.GA26221@home.buserror.net>
 <D473A0D087F4EA47A30C37E4637E25E609DAD274@039-SN2MPN1-021.039d.mgd.msft.net>
In-Reply-To: <D473A0D087F4EA47A30C37E4637E25E609DAD274@039-SN2MPN1-021.039d.mgd.msft.net>
 (from B43644@freescale.com on Tue Jul 23 03:01:17 2013)
Message-ID: <1374621854.15592.44@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Hu Mingkai-B21284 <B21284@freescale.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/23/2013 03:01:17 AM, Liu Po-B43644 wrote:
>=20
> >  -----Original Message-----
> >  From: Wood Scott-B07421
> >  Sent: Tuesday, July 23, 2013 6:41 AM
> >  To: Liu Po-B43644
> >  Cc: linuxppc-dev@ozlabs.org; Hu Mingkai-B21284
> >  Subject: Re: [1/4] powerpc/85xx: Add SEC6.0 device tree
> >
> >  On Thu, Apr 25, 2013 at 09:54:14AM +0800, Po Liu wrote:
> >  > From: Mingkai Hu <Mingkai.Hu@freescale.com>
> >  >
> >  > Add device tree for SEC 6.0 used on C29x silicon.
> >  >
> >  > Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
> >  > Singed-off-by: Po Liu <Po.Liu@freescale.com>
> >
> >  I've heard of patches being flamed, but here we want signing, not
> >  singeing. :-)
> >
> >  Don't forget that you can use the -s option to have git add the =20
> signoff
> >  for you.
> >
> >  > ---
> >  > Base on git://git.am.freescale.net/gitolite/mirrors/linux-2.6.git
> >
> >  This URL is not accessible outside Freescale, so don't reference =20
> it when
> >  posting patches publicly.
> >
> >  If your patch is against the latest upstream code, you don't need =20
> to say
> >  anything special about that.  You only need to make a note when =20
> it's
> >  against some other yet-to-be-merged tree or patch.
> >
> >  > +	compatible =3D "fsl,sec-v6.0", "fsl,sec-v5.2",
> >  > +		     "fsl,sec-v5.0", "fsl,sec-v4.4",
> >  > +		     "fsl,sec-v4.0";
> >  > +	fsl,sec-era =3D <6>;
> >  > +	#address-cells =3D <1>;
> >  > +	#size-cells =3D <1>;
> >  > +
> >  > +	jr@1000 {
> >  > +		compatible =3D "fsl,sec-v6.0-job-ring",
> >  > +			     "fsl,sec-v5.2-job-ring",
> >  > +			     "fsl,sec-v5.0-job-ring",
> >  > +			     "fsl,sec-v4.4-job-ring",
> >  > +			     "fsl,sec-v4.0-job-ring";
> >  > +		reg	   =3D <0x1000 0x1000>;
> >  > +	};
> >  > +
> >  > +	jr@2000 {
> >  > +		compatible =3D "fsl,sec-v6.0-job-ring",
> >  > +			     "fsl,sec-v5.2-job-ring",
> >  > +			     "fsl,sec-v5.0-job-ring",
> >  > +			     "fsl,sec-v4.4-job-ring",
> >  > +			     "fsl,sec-v4.0-job-ring";
> >  > +		reg	   =3D <0x2000 0x1000>;
> >  > +	};
> >
> >  You claim compatibility with a bunch of prior SECs, but sec-v5.2 =20
> has four
> >  job rings and an rtic node.  Likewise for the previous compatibles =20
> listed.
> >  This has two job rings and no rtic.
> So, shall I remove "fsl,sec-v5.2","fsl,sec-v5.0", "fsl,sec-v4.4", =20
> "fsl,sec-v4.0" since all other SEC with 4 job rings? and only leave =20
> "fsl,sec-v6.0"?

Yes, I think so.

> >  Can you point to where in the SEC v4.0 binding (I don't see a =20
> binding for
> >  the subsequent versions), it says that these are optional?
> I found SEC V4.0 in file qoriq-sec4.0-0.dtsi. If "fsl,sec-v4.0" not =20
> in the compatible list, it is no use in this compatible list. But =20
> seems keep the "fsl,sec-v4.0-job-ring" job ring compatible is ok. Is =20
> that what you were ask?

No, I was talking about binding documents:
Documentation/devicetree/bindings/crypto/

-Scott=
