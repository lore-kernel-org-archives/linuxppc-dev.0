Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B8499DDF55
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 19:40:09 +1000 (EST)
Subject: Re: [PATCH v2] [2.6.22] pasemi: cpufreq driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070426203710.GB17302@lixom.net>
References: <20070425204633.GC19781@lixom.net>
	<20070426053700.GA23922@lixom.net>
	<1177583160.6814.37.camel@johannes.berg>
	<20070426203710.GB17302@lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-mUg4s20WoJnePDUqzhIL"
Date: Fri, 27 Apr 2007 11:40:03 +0200
Message-Id: <1177666803.7828.30.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, egor@pasemi.com, paulus@samba.org, arnd@arndb.de,
	cpufreq@lists.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-mUg4s20WoJnePDUqzhIL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-04-26 at 15:37 -0500, Olof Johansson wrote:

> You can set the requested speed per-processor, but the actual speed
> will be the max of them. Because of this, it's less surprising to set
> it on both at the same time since then you'll at least know what you're
> running at.
>=20
> So yes, I'll change it to online_map instead of possible_map.

Ok, yeah, so effectively they all just go together (that additional
complication of running at the max probably should be hidden as you
note)

> Hmm, I just tried adding debugging to the cpu_init code, and I'm not
> seeing it called more than once (i.e. only for cpu 0). Mind you, I don't
> have cpu hotplug support at this time.

Oh right, you need cpu hotplug support for the bug to show up. What
happens then is you unplug and replug a CPU and the sysfs cpufreq stuff
for the CPU you just replugged is gone.

johannes

--=-mUg4s20WoJnePDUqzhIL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGMcTz/ETPhpq3jKURAqPRAKCM6VZoX11OIWIN/EzQLp60ly2YDwCgmz2a
Xsr6asMNPK9qt4benaVz8MU=
=VSPs
-----END PGP SIGNATURE-----

--=-mUg4s20WoJnePDUqzhIL--
