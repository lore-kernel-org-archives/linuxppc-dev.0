Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 143C5DE0CE
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2008 00:33:18 +1000 (EST)
Date: Thu, 28 Aug 2008 00:33:08 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [BUG] linux-next: Tree for August 26 - Badness at
	kernel/notifier.c:25
Message-Id: <20080828003308.400038e0.sfr@canb.auug.org.au>
In-Reply-To: <48B55B16.7060804@linux.intel.com>
References: <20080826184008.6be39f19.sfr@canb.auug.org.au>
	<48B44B2D.8070809@linux.vnet.ibm.com>
	<48B46610.1010809@linux.intel.com>
	<48B53695.3020703@linux.vnet.ibm.com>
	<48B55B16.7060804@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__28_Aug_2008_00_33_08_+1000_YX5+22H_Giwkidmk"
Cc: LKML <linux-kernel@vger.kernel.org>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__28_Aug_2008_00_33_08_+1000_YX5+22H_Giwkidmk
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Arjan,

On Wed, 27 Aug 2008 06:48:06 -0700 Arjan van de Ven <arjan@linux.intel.com>=
 wrote:
>
> Kamalesh Babulal wrote:
> >=20
> > Thanks for reference of the patch, After replacing the patch with the l=
atest=20
> > one above on the powerpc, the warning still remains
> >=20
> > Badness at kernel/notifier.c:86
>=20
> sadly you have something going on that doesn't list the modules loaded et=
c...
>=20
> is this during boot or way later?
> (because if it's the later, you might be hitting a legitimate bug ;-)

The original reported trace was during setup_system which is very early in
the boot.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__28_Aug_2008_00_33_08_+1000_YX5+22H_Giwkidmk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAki1ZaQACgkQjjKRsyhoI8z5vwCgl4ClHwY0QMDLBsBxl3/sIoe7
m9IAnA/GYD5p9M+lO0PUllTxajVvzhOC
=UinA
-----END PGP SIGNATURE-----

--Signature=_Thu__28_Aug_2008_00_33_08_+1000_YX5+22H_Giwkidmk--
