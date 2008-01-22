Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 23 Jan 2008 01:34:04 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 2/4] Create and hook up of_platform_device_shutdown
Message-Id: <20080123013404.d8445270.sfr@canb.auug.org.au>
In-Reply-To: <bb8d7cc1a060af291ef6efb0f4222f81fa91f417.1200999872.git.michael@ellerman.id.au>
References: <3ce7be4c77581ce103a8da9f33a734270c9dc6e8.1200999872.git.michael@ellerman.id.au>
	<bb8d7cc1a060af291ef6efb0f4222f81fa91f417.1200999872.git.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__23_Jan_2008_01_34_04_+1100_tjovSH=pW2WkiWrm"
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__23_Jan_2008_01_34_04_+1100_tjovSH=pW2WkiWrm
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michael,

Just a couple of things.

On Tue, 22 Jan 2008 22:04:40 +1100 (EST) Michael Ellerman <michael@ellerman=
.id.au> wrote:
>
> +static void of_platform_device_shutdown(struct device * dev)
                                                          ^
No space, please.

Also, I wonder if we should check that the drivers that already have
specified a shutdown routine (drivers/input/misc/sparcspkr.c,
drivers/usb/host/ohci-ppc-of.c and drivers/watchdog/mpc5200_wdt.c) are
actually ok if it actually gets called.  :-)

Also, patches like this should be cc'd to (at least) the sparc guys
(sparclinux@vger.kernel.org) since they share this stuff with us, now.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__23_Jan_2008_01_34_04_+1100_tjovSH=pW2WkiWrm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHlf7hTgG2atn1QN8RAom3AJ0a+jXFFTxp/aopWgRq8vX5ohbONgCeJJwJ
cCRsTjZlt73f4uV1OUpWNhE=
=nVxm
-----END PGP SIGNATURE-----

--Signature=_Wed__23_Jan_2008_01_34_04_+1100_tjovSH=pW2WkiWrm--
