Return-Path: <dedekind1@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id B42631007D7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 19:15:47 +1100 (EST)
Received: by iafi7 with SMTP id i7so2766165iaf.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 00:15:44 -0800 (PST)
Subject: RE: [PATCH 3/3] mtd/nand : workaround for Freescale FCM to support
 large-page Nand chip
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Li Yang-R58472 <r58472@freescale.com>
Date: Thu, 24 Nov 2011 10:16:25 +0200
In-Reply-To: <3F607A5180246847A760FD34122A1E052DC61F@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1322095306-13156-1-git-send-email-b35362@freescale.com>
 <1322095306-13156-3-git-send-email-b35362@freescale.com>
 <1322120515.24797.296.camel@sauron.fi.intel.com>
 <3F607A5180246847A760FD34122A1E052DC61F@039-SN1MPN1-003.039d.mgd.msft.net>
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-fjMxwjwmtk5cQh7hPUAn"
Message-ID: <1322122592.24797.299.camel@sauron.fi.intel.com>
Mime-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "Artem.Bityutskiy@nokia.com" <Artem.Bityutskiy@nokia.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Liu Shuo-B35362 <B35362@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-fjMxwjwmtk5cQh7hPUAn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2011-11-24 at 07:49 +0000, Li Yang-R58472 wrote:
> > Subject: Re: [PATCH 3/3] mtd/nand : workaround for Freescale FCM to sup=
port
> > large-page Nand chip
> >=20
> > On Thu, 2011-11-24 at 08:41 +0800, b35362@freescale.com wrote:
> > > +               /*
> > > +                * Freescale FCM controller has a 2K size limitation =
of buffer
> > > +                * RAM, so elbc_fcm_ctrl->buffer have to be used if w=
ritesize
> > > +                * of chip is greater than 2048.
> > > +                * We malloc a large enough buffer (maximum page size=
 is
> > 16K).
> > > +                */
> > > +               elbc_fcm_ctrl->buffer =3D kmalloc(1024 * 16 + 1024,
> > GFP_KERNEL);
> >=20
> > Are there NANDs with 16KiB page size?
>=20
> We are not sure, but are there possibility that chip with 16K page will a=
ppear?  Or maybe we can add a MACRO for the maximum page size?

I do not know, but I know that allocating 32KiB of contiguous physical
RAM may cause unneeded memory pressure and even fail if the memory is
too fragmented. So I would not go for this unless this is necessary.

Did you try to look how the NAND base interface could be changed to
avoid re-allocation altogether, BTW?

--=20
Best Regards,
Artem Bityutskiy

--=-fjMxwjwmtk5cQh7hPUAn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJOzf1ZAAoJECmIfjd9wqK01F8P/2iydA04dZPfl+fGg4twydxA
ihpnMilQKxfZ843PnFhqkmdW0f+1zOi0HxWJM6bvOvCNFZEODLNkPixTw0gmi1Y9
eiixLspe/icyKrbfyNDkYgtHX3uxQcJGLWLtvPj/72BZqA2Kf07Ls/kc9yvZJEIY
l7hwjXRlzb5rNjhcZjxaaxgOupIEkP93rhyyG8nX2n1Dq7o6+XFZH9eDi4R4FLps
or6Ls3/tnBAlPQzuyYTEVyfY+fLI8VufsXbjKSo7wP5PklZY/Ig+PoA0J5muKVhG
SH3M8z6TOzKMtRyRkgT4j2OJYc8z2XdpYvbRfNhkRXAZaTHIL2qEY6grI6qucVMM
KbM5Zc5Ag/aZgTCju38BUUYncmLTRTdBRVOWcs+bu1lS/Eo1zYMG037BnDnIPeDv
1Q/4D67vfhFl7fFcFn1AL9X6Y816ncYehcjHberCe5GEwQ4eV99WrzIze+XMbSDG
x+2K53zg0+qOCVtl+Hhuxu97d5Da2Nfdflk4b79lQt1JW5oOqDv/xr7XRmrO42C/
g2C0znwiSAgBEu6M5vL63K6bnILDkpLsMdCTJqUTasFYma2yBvqRgP4/NAJYWhBB
Kn72QYV6oKKE2NtvSZ22cPSu9kBsWuqlMIvZaRhWFI6Q1MURfnfkZ5QxUiU+NYk/
RGFz1FL15Z2QrLbpsgGl
=2uYC
-----END PGP SIGNATURE-----

--=-fjMxwjwmtk5cQh7hPUAn--
