Return-Path: <balbi@ti.com>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
	[74.125.149.209])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EBAF8B6FC3
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Jun 2011 21:57:36 +1000 (EST)
Received: by mail-bw0-f49.google.com with SMTP id 1so4855005bwz.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Jun 2011 04:57:31 -0700 (PDT)
Date: Mon, 13 Jun 2011 14:57:26 +0300
From: Felipe Balbi <balbi@ti.com>
To: Tanya Brokhman <tlinder@codeaurora.org>
Subject: Re: [PATCH] usb:gadget: use min_t() macro instead of min()
Message-ID: <20110613115723.GN3633@legolas.emea.dhcp.ti.com>
References: <1307877290-26672-1-git-send-email-tlinder@codeaurora.org>
	<20110613092438.GK3633@legolas.emea.dhcp.ti.com>
	<03b901cc29c0$6538e970$2faabc50$@org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="prC3/KjdfqNV7evK"
In-Reply-To: <03b901cc29c0$6538e970$2faabc50$@org>
Cc: "'open list:FREESCALE USB PER...'" <linuxppc-dev@lists.ozlabs.org>,
	greg@kroah.com, linux-usb@vger.kernel.org,
	'open list' <linux-kernel@vger.kernel.org>, balbi@ti.com,
	linux-arm-msm@vger.kernel.org,
	"'open list:OMAP USB SUPPORT'" <linux-omap@vger.kernel.org>,
	ablay@codeaurora.org
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--prC3/KjdfqNV7evK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 13, 2011 at 02:52:34PM +0300, Tanya Brokhman wrote:
> > On Sun, Jun 12, 2011 at 02:14:46PM +0300, Tatyana Brokhman wrote:
> > > Signed-off-by: Tatyana Brokhman <tlinder@codeaurora.org>
> >=20
> > I need a sensible commit log for this. Why do we need to change all
> > min() to min_t() ?
> >=20
>=20
> Actually, Alan asked me to make this change in one place in dummy_hcd. I
> wasn't aware of the min_t macro before that. So when I searched the code =
for
> other places I found quite a few and just thought that it would be "nicer"
> to use min_t() instead of min() with casting.=20
> So we don't "need" to make this change. Everything works as is. This patch
> only makes the code look nicer, nothing more.
> I can elaborate the above in the commit log if you want.

Yes, that's what I need. The question was supposed to be answered by the
commit log ;-)

--=20
balbi

--prC3/KjdfqNV7evK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN9fsjAAoJEAv8Txj19kN1lLUH/R6eacJNptNb0Du6BBS4XTKU
gd4jqe3RWib8Yhe7q395ySJM/i9IgAgAc3sfRAO+jQWQdHr54ZusbRRB9Xor+OJk
uaS0dK+h2s2iDuKW5uXziVJgxeJBBGP1ehSgRErEqbB26XO3pUC5Zv5xpRVtDhv8
c/kNE/v1NhpTvoncCS7NvYMyoaamK5WCE0EKGlbhquMXI/rL7FCrG+uXXcVVinXu
8SPTYyoRiOGEgeHkaz3+qThM9RTy7dtsKfy3DOgyr7dYQ6yHLusHJ6mdja3PcJng
ufEQTsLdEPZxxlrcyUvq0xnBjN2JsnY2ApmLq2oMlQBi9/fp8KCPZYd88ry8bWI=
=IYJJ
-----END PGP SIGNATURE-----

--prC3/KjdfqNV7evK--
