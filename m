Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 945BFDDDFD
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 09:11:20 +1000 (EST)
Subject: Re: [Bugme-new] [Bug 11629] New: quad G5 fails to shut down
From: Johannes Berg <johannes@sipsolutions.net>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <1222209915.18015.51.camel@johannes.berg>
References: <bug-11629-10286@http.bugzilla.kernel.org/>
	<20080923143057.e3e54536.akpm@linux-foundation.org>
	<1222209915.18015.51.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-6GmWdeA5KBMaQvlGWBOR"
Date: Wed, 24 Sep 2008 01:10:32 +0200
Message-Id: <1222211432.18015.55.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>, bugme-daemon@bugzilla.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-6GmWdeA5KBMaQvlGWBOR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-09-24 at 00:45 +0200, Johannes Berg wrote:

> Well, that does seem to fix the regression. That is, it no longer
> crashes.

Spoke too early, it seems that the crash isn't exactly reproducible all
the time nor happens at the same spot all the time. I'd suspect that the
timer code isn't to blame but something in the IPI code or so.

johannes

--=-6GmWdeA5KBMaQvlGWBOR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJI2XdkAAoJEKVg1VMiehFYYjYQAIiqSNXIbVZ9n8N1YW/GKFdu
nKKHa/tH2Z4KpS0tyzsEmQ6A32ih7fajBRUyqLgTsieFnZhqHslnsojaysJTIDCk
RwwVfPFOX6gGyElPwfs+FgfFmGrGbrehO2NWfXpeBWhjtKgYB9qfwi9sP6VYj8PI
6+sVOAzTpv0oXNa0QBrQBCF80KWRUGHP2vsMAkLhkpV1ugXMdSEeynlwWi+4lnp+
EVu/miL9zW6G56cF9erz4pBdROhtLlk5nc/ru9e5Z1xUWnpHmO6MH1yfctVgZdNE
s6qKcPvuJ6Rx3FIzIufIIg7y2Jp93kycaZhX9OpvtFkLGP/htJqa0oes9BLE5OJZ
dEzdMOSBOKk7giaFwJ1anAFBKixfajJ8M2QweRUYdebXCwsNmhZDmpbJbICVyUam
HuZEcLqjfLgvjpbUCJ14J774l1xcjqA2rWMWnfGwpizekURrVfGEGpylIfpxR7hC
pWX+z34YQl5hcfC155h+TDjOcmTQudQC6tCznZHTFKPZfRVe6XLayiP9saIeO94h
FbPGEBm7FsPeh2G3+FBLfdfehT/UHz9jSFhRmN6/Rj1+Jb5uwQofzxUQv3jK6KvG
ZXQ2z7NtWSKObKCdoAbTsWfz8F2Fp82PSj2+6u4bi6Zu+AsxDQ+ZI3o5NsgfFr1W
A1by0qD8GZZd+BrAde9C
=Cpgx
-----END PGP SIGNATURE-----

--=-6GmWdeA5KBMaQvlGWBOR--
