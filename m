Return-Path: <joerg@dorchain.net>
Received: from Redstar.dorchain.net (153-133-088-212.ip-addr.teresto.net
	[212.88.133.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8F9BA67A46
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2005 01:06:54 +1100 (EST)
Date: Tue, 15 Mar 2005 15:03:30 +0100
From: Joerg Dorchain <joerg@dorchain.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050315140329.GA15214@Redstar.dorchain.net>
References: <1110767622.5787.215.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
In-Reply-To: <1110767622.5787.215.camel@gaston>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: Newer laptops & CPU speed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 14, 2005 at 01:33:42PM +1100, Benjamin Herrenschmidt wrote:
> It seems the new laptops are booting with CPU set to low
> speed. /proc/cpuinfo outputs the wrong fequency (thinks it's high speed)
> but bogomips shows that it's running at about half speed. This patch
> against 2.6.11 (will not apply on 2.6.10) adds proper cpufreq support so
> that the boot speed is recognized (fixing /proc/cpuinfo output) and so
> you can acutally use cpufreq interface & utilities to switch to full
> speed (I recommend powernowd).
>=20
> This is completely untested as I don't have access to any of those new
> models yet, so I'm waiting for some feedback before submitting upstream.

My ibook G4 boots at low speed. /proc/cpuinfo shows 666MHz and a smiliar
bogomips value. Nevertheless, the cpu frequency scaler works, i.e. set
it to performance to be at high speed after boot up, or, as I currently
do, use the userspace governor and powernowd. All this is without your
patch (Did not try it yet, my ibook lacks internet) on linus' 2.6.11.

Bye,

Joerg


--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCNusxjY4+4PdzvOARAlUQAJ4rlTgDKfxWyFZf0TH+WskvJzQOxgCeN2tF
XBlPq2yVnsBqT0DrLwiCpBg=
=f5HG
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
