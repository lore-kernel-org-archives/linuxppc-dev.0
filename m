Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 87A04DE0AB
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 10:14:31 +1000 (EST)
Date: Tue, 19 May 2009 10:14:19 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3] powerpc/pci: clean up direct access to sysdata by
	iseries platform
Message-Id: <20090519101419.d0820f28.sfr@canb.auug.org.au>
In-Reply-To: <1242651387-13194-1-git-send-email-galak@kernel.crashing.org>
References: <1242651387-13194-1-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__19_May_2009_10_14_19_+1000_fg0O3ae0iD3+_1H9"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__19_May_2009_10_14_19_+1000_fg0O3ae0iD3+_1H9
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

On Mon, 18 May 2009 07:56:27 -0500 Kumar Gala <galak@kernel.crashing.org> w=
rote:
>
> We shouldn't directly access sysdata to get the device node.  We should
> be calling pci_device_to_OF_node().
>=20
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> * Fixed compile error (dev -> pdev)

I tested the previous version with the typo fixed, so assuming that you
changed nothing else,

Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__19_May_2009_10_14_19_+1000_fg0O3ae0iD3+_1H9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoR+dsACgkQjjKRsyhoI8zaggCfb9FxA6+j9yXyDxMXycyfY/cO
aysAmwQ3241GalI8xQb7bC6RGXgeIncQ
=j/4c
-----END PGP SIGNATURE-----

--Signature=_Tue__19_May_2009_10_14_19_+1000_fg0O3ae0iD3+_1H9--
