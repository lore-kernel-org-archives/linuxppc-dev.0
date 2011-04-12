Return-Path: <jeffrey.t.kirsher@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by ozlabs.org (Postfix) with ESMTP id E5876B6F35
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Apr 2011 07:42:28 +1000 (EST)
Subject: Re: [E1000-devel] [PATCH] driver/e1000e: Fix default interrupt
	mode select
From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
In-Reply-To: <1302584163-22318-1-git-send-email-prabhakar@freescale.com>
References: <1302584163-22318-1-git-send-email-prabhakar@freescale.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-RZ+CXRTw+PMcxLaW05gE"
Date: Tue, 12 Apr 2011 14:32:35 -0700
Message-ID: <1302643955.2950.13.camel@jtkirshe-MOBL1>
Mime-Version: 1.0
Cc: "meet2prabhu@gmail.com" <meet2prabhu@gmail.com>, "Kok,
	Auke-jan H" <auke-jan.h.kok@intel.com>, Jin Qing <b24347@freescale.com>,
	"e1000-devel@lists.sourceforge.net" <e1000-devel@lists.sourceforge.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Linux NICS <linuxnics@mailbox.intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-RZ+CXRTw+PMcxLaW05gE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2011-04-11 at 21:56 -0700, Prabhakar Kushwaha wrote:
> From: Prabhakar <prabhakar@freescale.com>
>=20
> The Intel e1000 device driver defaults to MSI interrupt mode, even if
> MSI
> support is not enabled
>=20
> Signed-off-by: Jin Qing <b24347@freescale.com>
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> ---
>  Based upon
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git(bran=
ch master)
>=20
>  added  netdev mail-list and e1000 mail-list & maintainer
>=20
>  drivers/net/e1000e/param.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)=20

Thanks for the patch, I have added it to my queue of e1000e patches.

--=-RZ+CXRTw+PMcxLaW05gE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJNpMTzAAoJECTsCADr/EWUgYwH/13wfNEaLVjDkMPbdarsaKBN
XAoyY9/kZZpDacIm2FdbVYFcDjTRi3EO2PIQHvE8CZKmDx60VgTSSzrvpWp7zpdq
YpQNh2oQPEswS9LVHzyQRcRo8dt3wjlkYuaC9r2yYgfIW/lSr1yOdwQL3ulAI8C/
18bzGdWEBxeyTIghB4RG2n5tVd7765R83Kg869hP4LkB/jfDhTW8zLS06atGmo5h
cIJ6JtJF/UULdhp03RISh7wtHkpRG10cPoZJh3ygtaXGEuF92aovc63jpO6gABv4
4LVVN8zS9oycaIRMJm1AnV4cCMv7rrN3aKWNSKMn4AYiEWotLTsZkw01CLOcltQ=
=hNIT
-----END PGP SIGNATURE-----

--=-RZ+CXRTw+PMcxLaW05gE--
