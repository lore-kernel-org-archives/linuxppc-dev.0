Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A9E7EDDE0F
	for <linuxppc-dev@ozlabs.org>; Wed,  6 May 2009 23:13:42 +1000 (EST)
Date: Wed, 6 May 2009 23:13:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/pci: clean up direct access to sysdata by
	iseries platform
Message-Id: <20090506231338.ea3e280d.sfr@canb.auug.org.au>
In-Reply-To: <1241525095-18041-1-git-send-email-galak@kernel.crashing.org>
References: <1241525095-18041-1-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__6_May_2009_23_13_38_+1000_qa+GfUdEd+iP9MTp"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__6_May_2009_23_13_38_+1000_qa+GfUdEd+iP9MTp
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

On Tue,  5 May 2009 07:04:55 -0500 Kumar Gala <galak@kernel.crashing.org> w=
rote:
>
> We shouldn't directly access sysdata to get the device node.  We should
> be calling pci_device_to_OF_node().
>=20
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

It looks ok, but all I can say for now is that it doesn not make things
worse.  During 2.6.28, the iSeries PCI code was broken.  I am working on
a fix and after that I will be able to properly test this patch.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__6_May_2009_23_13_38_+1000_qa+GfUdEd+iP9MTp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoBjQIACgkQjjKRsyhoI8zwuACeKFAkYCovGd8KLo6URTw7d30o
rbYAn0C2xY2ER5UJWegxyNN4l/lGAjOW
=3iRC
-----END PGP SIGNATURE-----

--Signature=_Wed__6_May_2009_23_13_38_+1000_qa+GfUdEd+iP9MTp--
