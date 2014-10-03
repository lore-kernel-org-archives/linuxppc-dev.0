Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E93F1A0AD5
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Oct 2014 09:06:52 +1000 (EST)
Date: Sat, 4 Oct 2014 09:06:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Pull request: scottwood/linux.git next
Message-ID: <20141004090645.68c75442@canb.auug.org.au>
In-Reply-To: <1412365973.13320.430.camel@snotra.buserror.net>
References: <20140922222142.GA8525@home.buserror.net>
 <1412365973.13320.430.camel@snotra.buserror.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ANb0w9WogVf._3jXZEB7H/V"; protocol="application/pgp-signature"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/ANb0w9WogVf._3jXZEB7H/V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Scott,

On Fri, 3 Oct 2014 14:52:53 -0500 Scott Wood <scottwood@freescale.com> wrot=
e:
>
> On Mon, 2014-09-22 at 17:21 -0500, Scott Wood wrote:
> > Highlights include DMA32 zone support (SATA, USB, etc now works on 64-b=
it
> > FSL kernels), MSI changes, 8xx optimizations and cleanup, t104x board
> > support, and PrPMC PCI enumeration.
> >=20
> > The following changes since commit 78eb9094ca08a40b8f9d3e113a2b88e0b7db=
ad1d:
> >=20
> >   powerpc/t2080rdb: Add T2080RDB board support (2014-07-31 00:11:10 -05=
00)
> >=20
> > are available in the git repository at:
> >=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next
> >=20
> > for you to fetch changes up to cb0446c1b625326682ec4f9d1dd10779433646bc:
> >=20
> >   Revert "powerpc/fsl_msi: spread msi ints across different MSIRs" (201=
4-09-19 15:20:42 -0500)
>=20
> ping

Probably worth explicitly pinging Michael (cc'd) as he is doing this
merge window's collection ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/ANb0w9WogVf._3jXZEB7H/V
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJULywKAAoJEMDTa8Ir7ZwVSvwP/28KHagW5k1gM+GC9gBMIX1v
tyyONCqDjZfGI52wTrraQgKnWFEhzXJhNUoBIXUX5Yfbz2VohiH4BaQthogNgO1g
OI1NDpFDAER1AyDzk9+VtAiBlcThlGlP2YbE/Tmba4dkFCJ9Xsli7WlUU/+YRph0
Zf+WKYrJXQ0KgUl5nMO+yE6Iy7xC2Mjhw/nK8Qk7wiJNEjOyxqDHjzEa6dYhDfqh
kSx79ZPXmhKGquaFnC1G1YNg4yKU/pjoVLR9O/kwheIosDKBsLBUWV6RVrl8oS9E
SfuQ1E2YsEywTZIVd0ml2bCS/WY+q9xeFTncPpHy3XmzKAViiaWdOlMJ1S7o8dxy
/XbDMgc7Z+BsrywVDHCce4s++Z/84HMMOObjwDtrJCRd8BgWhUhqR3/nheDS2xmV
Xb9On/W55bMc1O+J5xrsZXltYPXDxFV+FkX0owJRdnTH2d16s9NOF2KD/Mkunwn2
wdZyV9Q+YR6p8yGJ/E5XzaPk4vSp6eQ8VePfLW6blTYrsFPeVpLe10Tsz5TBcc07
A3sE3cT8oKyguEZogZ2z/UpLJSZWAUhfQOfcUJiE9xZEfBOZa559jVmBEkBLpI8c
cp41i5RAkgQ13Wd0BNius9drKpCmeBskvw19t6vlwSZ7hnTfCO76eN0Gzl8eO3zo
ttHBaySXtDZvFlxTH5hE
=qzRd
-----END PGP SIGNATURE-----

--Sig_/ANb0w9WogVf._3jXZEB7H/V--
