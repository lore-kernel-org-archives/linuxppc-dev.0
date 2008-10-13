Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A3273DE110
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 09:44:26 +1100 (EST)
Date: Tue, 14 Oct 2008 09:44:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Martyn Welch <martyn.welch@gefanuc.com>
Subject: Re: [PATCH v3] powerpc: FPGA support for GE Fanuc SBC610
Message-Id: <20081014094418.5f3c004a.sfr@canb.auug.org.au>
In-Reply-To: <20081013151537.19033.25006.stgit@ubuntu8041.localdomain>
References: <20081013151537.19033.25006.stgit@ubuntu8041.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__14_Oct_2008_09_44_18_+1100_fFEd0kfSJjRCRqqp"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__14_Oct_2008_09_44_18_+1100_fFEd0kfSJjRCRqqp
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Oct 2008 16:16:45 +0100 Martyn Welch <martyn.welch@gefanuc.com> =
wrote:
>
> Support for the SBC610 VPX Single Board Computer from GE Fanuc (PowerPC
> MPC8641D).
>=20
> This patch adds support for the registers held in the devices main FPGA,
> exposing extra information about the revision of the board through cpuinf=
o.
>=20
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
>=20
> Stephen: Thanks for spotting that error.
>=20
> New to rev 3:
>  * Added of_node_put()

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au> for of accessing

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__14_Oct_2008_09_44_18_+1100_fFEd0kfSJjRCRqqp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjzz0IACgkQjjKRsyhoI8xO/wCgqlk3pd/bEXpyCmOrNDBsJRhQ
woAAn0ivGf4byQ2L8aoAzmx2Lq2n/S2a
=4qYK
-----END PGP SIGNATURE-----

--Signature=_Tue__14_Oct_2008_09_44_18_+1100_fFEd0kfSJjRCRqqp--
