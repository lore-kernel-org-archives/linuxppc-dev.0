Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0F9F6DE197
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Jan 2009 10:28:09 +1100 (EST)
Date: Mon, 5 Jan 2009 10:28:00 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>
Subject: Re: linux-next: manual merge of the driver-core tree
Message-Id: <20090105102800.c73bed11.sfr@canb.auug.org.au>
In-Reply-To: <20081204042154.GA18027@kroah.com>
References: <20081204104418.97f848b4.sfr@canb.auug.org.au>
	<20081204042154.GA18027@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__5_Jan_2009_10_28_00_+1100_uKX3m5EZk7JusMsB"
Cc: Kumar, Kay Sievers <kay.sievers@vrfy.org>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__5_Jan_2009_10_28_00_+1100_uKX3m5EZk7JusMsB
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Wed, 3 Dec 2008 20:21:54 -0800 Greg KH <greg@kroah.com> wrote:
>
> On Thu, Dec 04, 2008 at 10:44:18AM +1100, Stephen Rothwell wrote:
> >=20
> > Today's linux-next merge of the driver-core tree got a conflict in
> > arch/powerpc/platforms/85xx/mpc85xx_mds.c between commit
> > 24a99596f7465274a8e65ddd29a7d9028969b9f9 ("powerpc/85xx: Fix compile
> > warnings in mpc85xx_mds.c") from the galak tree and commit
> > f58f23751464d095f9942304bc5f6072b79a2cc3 ("powerpc: struct device -
> > replace bus_id with dev_name(), dev_set_name()") from the driver-core
> > tree.
> >=20
> > I fixed it up (see below) and can carry the fix as necessary.
> >=20
> > Paul, maybe you should apply the patch from the driver-core tree as it
> > was cc'd to you and all its prerequisites are upstream.
>=20
> Yes, Paul, please apply the patch, and let me know.  It will make things
> much easier in the end for everyone involved.

It looks like this has been applied to the powerpc tree and is now in
Linus' tree.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__5_Jan_2009_10_28_00_+1100_uKX3m5EZk7JusMsB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklhRgAACgkQjjKRsyhoI8wISACguEoWL/6mMchylc2hf7XDZUDp
ucQAn0w11gcpUIiGryrbaw156ZM0CYn7
=6EXZ
-----END PGP SIGNATURE-----

--Signature=_Mon__5_Jan_2009_10_28_00_+1100_uKX3m5EZk7JusMsB--
