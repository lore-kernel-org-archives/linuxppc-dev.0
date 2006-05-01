Return-Path: <robbat2@gentoo.org>
Received: from mail.net-conex.com (pops.net-conex.com [204.244.176.3])
	by ozlabs.org (Postfix) with ESMTP id 0794B67AC5
	for <linuxppc-dev@ozlabs.org>; Mon,  1 May 2006 10:27:16 +1000 (EST)
Received: from curie.orbis-terrarum.net (S01060050da688d47.vc.shawcable.net
	[24.80.100.253])
	by mail.net-conex.com (8.13.4/8.12.11) with ESMTP id k410REDU016475
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Apr 2006 17:27:14 -0700
Date: Sun, 30 Apr 2006 17:27:19 -0700
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: linuxppc-dev@ozlabs.org
Subject: windfarm for PM72/PM73/RM31
Message-ID: <20060501002719.GD15141@curie-int.vc.shawcable.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6Nae48J/T25AfBN4"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--6Nae48J/T25AfBN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm working on writing a windfarm driver for the PM72/PM73/RM31 boxes,
amongst some other windfarm work I'm doing, and I have a few quick
notes/questions:

Process so far/TODO list:
- I've got the ds1775 and max6690 chips returning all of their data on
  PowerMac11,2 and PowerMac7,3. I need to change the detection code for the
  max6690 sub-nodes (it has both internal and external temps) as they
  don't exist on PM72.
- Need to write windfarm sensor drivers for: ds1631, ad7417, lm87
- Flesh out my windfarm_pm72 more - it's based on the therm_pm72
  constants and the pm112 module for now, completely untested until I
  have the sensors and controllers hooked up.

Questions:
1. Message naming consistancy - there are a number of printk/DBG
statements that seem to flip randomly between using a prefix of
'windfarm:' or 'wf:', and then some that omit it entirely.
Any consensus on which one is preferred?

2. Could somebody please send me a tarball of /proc/device-tree/ from a
RackMac3,1 unit? I've got the data for PM72/73 already.

--=20
Robin Hugh Johnson
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--6Nae48J/T25AfBN4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD4DBQFEVVXnPpIsIjIzwiwRAkBhAJjjnUDmfEqUl7pqoIwWHed39xkLAJ9153oz
/8Qz1PoZzHVph92Iw1InjA==
=aI6O
-----END PGP SIGNATURE-----

--6Nae48J/T25AfBN4--
