Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id DADCFDDE28
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2008 13:16:42 +1000 (EST)
Date: Thu, 28 Aug 2008 13:16:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] hotplug/rpaphp: remove unused error path code
Message-Id: <20080828131628.0db54f22.sfr@canb.auug.org.au>
In-Reply-To: <200808271634.06199.jbarnes@virtuousgeek.org>
References: <20080819114555.c0d2bd50.sfr@canb.auug.org.au>
	<200808271634.06199.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__28_Aug_2008_13_16_28_+1000_M2xyaxybVvd8P.=m"
Cc: Alex Chiang <achiang@hp.com>, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Linda Xie <lxie@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__28_Aug_2008_13_16_28_+1000_M2xyaxybVvd8P.=m
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jesse,

On Wed, 27 Aug 2008 16:34:03 -0700 Jesse Barnes <jbarnes@virtuousgeek.org> =
wrote:
>
> On Monday, August 18, 2008 6:45 pm Stephen Rothwell wrote:
> > Commit f46753c5e354b857b20ab8e0fe7b2579831dc369 ("PCI: introduce pci_sl=
ot")
> > removed the need for this error path.  Eliminate this warning:
> >
> > drivers/pci/hotplug/rpaphp_slot.c: In function 'rpaphp_register_slot':
> > drivers/pci/hotplug/rpaphp_slot.c:151: warning: label 'sysfs_fail' defi=
ned
> > but not used
> >
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>=20
> Applied to linux-next, thanks.

I has also been applied to the powerpc next tree, but that is ok.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__28_Aug_2008_13_16_28_+1000_M2xyaxybVvd8P.=m
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAki2GI0ACgkQjjKRsyhoI8xHkwCgn3/0Tz3qTuigMOMLoV9+XMn8
JXsAoLbMnd2n3FnParu2hTTOAFb3qjGv
=ltml
-----END PGP SIGNATURE-----

--Signature=_Thu__28_Aug_2008_13_16_28_+1000_M2xyaxybVvd8P.=m--
