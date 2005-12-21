Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 21 Dec 2005 16:13:30 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@gate.crashing.org>
Message-Id: <20051221161330.1a23384b.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.44.0512202045040.1835-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0512202045040.1835-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__21_Dec_2005_16_13_30_+1100_RQBU7IsOFttp6gZu"
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Call find_legacy_serial_ports() if we enable
 CONFIG_SERIAL_8250
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__21_Dec_2005_16_13_30_+1100_RQBU7IsOFttp6gZu
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Dec 2005 20:45:27 -0600 (CST) Kumar Gala <galak@gate.crashing.or=
g> wrote:
>
> In setup_arch and setup_system call find_legacy_serial_ports() if we
> build in support for 8250 serial ports instead of basing it on PPC_MULTIP=
LATFORM.
>=20
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>=20
> ---
> commit 399e10aa1c6a3ca64e8e8e8cea7289e9908cc62c
> tree 3e5320b8a97a37c4d010186aabf8a95e5be264b4
> parent 7b69a37a4e811e72e82896ab38e6ae04542455f5
> author Kumar Gala <galak@kernel.crashing.org> Tue, 20 Dec 2005 20:48:36 -=
0600
> committer Kumar Gala <galak@kernel.crashing.org> Tue, 20 Dec 2005 20:48:3=
6 -0600
>=20
>  arch/powerpc/kernel/setup_32.c |    2 +-
>  arch/powerpc/kernel/setup_64.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

You should probably change the Makefile as well to build legacy_serial.c
in the CONFIG_SERIAL_8250 case.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__21_Dec_2005_16_13_30_+1100_RQBU7IsOFttp6gZu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDqOSEFdBgD/zoJvwRAraSAJ9LpDS2U2AA8LDdU1Yi6KRid5iw/ACcCbGc
j/w7UHaaRm3I8aqzvHr338I=
=KrFG
-----END PGP SIGNATURE-----

--Signature=_Wed__21_Dec_2005_16_13_30_+1100_RQBU7IsOFttp6gZu--
