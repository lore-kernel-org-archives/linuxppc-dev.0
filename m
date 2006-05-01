Return-Path: <robbat2@gentoo.org>
Received: from mail.net-conex.com (pops.net-conex.com [204.244.176.3])
	by ozlabs.org (Postfix) with ESMTP id 700E967B32
	for <linuxppc-dev@ozlabs.org>; Mon,  1 May 2006 16:44:39 +1000 (EST)
Received: from curie.orbis-terrarum.net (S01060050da688d47.vc.shawcable.net
	[24.80.100.253])
	by mail.net-conex.com (8.13.4/8.12.11) with ESMTP id k416ibqF024765
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Apr 2006 23:44:37 -0700
Date: Sun, 30 Apr 2006 23:44:43 -0700
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: windfarm for PM72/PM73/RM31
Message-ID: <20060501064443.GA20481@curie-int.vc.shawcable.net>
References: <20060501002719.GD15141@curie-int.vc.shawcable.net>
	<A2D81A03-8CD5-41CD-BD49-3EDB1CDE53FD@laposte.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
In-Reply-To: <A2D81A03-8CD5-41CD-BD49-3EDB1CDE53FD@laposte.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 01, 2006 at 06:53:09AM +0200, ?tienne Bersac wrote:
> I own an iMac G5 rev C (iSight) with a PowerMac 12,1 included. Do you =20
> intend to make support for it ? I will be happy to help you :)
I'd like to start on the PM72 stuff first, but please tar up your
/proc/device-tree/ directory and email it to me, and I can see about it.

If Apple stuck to the same sensors (max6690, lm75. lm87, ds1775, ds1631,
ad7417), it should be reasonable simple to add your machine afterwards.

Is there actually a reasonable archive of the OF node trees somewhere?
It think it might be handy in developing drivers in future. I've
presently got: PowerBook4,3 PowerMac7,2 PowerMac7,3 PowerMac11,2

--=20
Robin Hugh Johnson
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFEVa5aPpIsIjIzwiwRAmBRAKD/B65zKakUib7VlPq9xX/sVK8X9QCg+OTK
1rz2SksOC4RlfC1Ab7dUQig=
=kTBa
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
