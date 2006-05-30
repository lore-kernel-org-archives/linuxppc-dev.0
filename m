Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 95AF667AC5
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 22:38:12 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC 5/7] snd-aoa: add layout-id fabric
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5h64jp9ge4.wl%tiwai@suse.de>
References: <20060528190026.754474000@johannes.berg>
	<20060528190129.503400000@johannes.berg> <s5h64jp9ge4.wl%tiwai@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-8WXs2ordTxhsmS7HleAU"
Date: Tue, 30 May 2006 14:37:55 +0200
Message-Id: <1148992675.3102.2.camel@johannes>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-8WXs2ordTxhsmS7HleAU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-05-29 at 14:14 +0200, Takashi Iwai wrote:

> Just from curiosity:  Does this work properly?
> I remember that there was a deadlock when you call request_module()
> during module probe.

Yes, it works, but I don't think this is actually done during module
probe (would have to check though)

johannes

--=-8WXs2ordTxhsmS7HleAU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHw8oKVg1VMiehFYAQIAZxAAxYEeGPjqDPEVb80eF/qjcv6mUrpPdQAy
27QIxHTarXSDOiSQ62TCrIBClosaxS7tBnPKL/Fo6XX6UjCjSY2Eks+JkFnvsb5X
JuzoxXb59KykKDfse8GRVqUQM4NYrCd0fLqcMWgk2o8gkChpfxtBnuak5LKDLMXp
ojiOBURYksY6h1odWQOBi+AzaocWKa3Xq0jzBpQL3/MbySe8ah6xKrH8fGV7V2Ee
e3fouWVo6hNLCcGZVJCCbZ1pMwwUYYWeiZzjWB925+S8naoVnqZ6XS+14MuzTbgJ
f8NGynhRrhi/UY9PI/TJJjmhukEMrfOujTLSbsHG4NabHAb1OjEjuXvqD1N4JvfB
9LlbbqzJPJUbeKOi9X2XkBL9o9Hd3rYjBTrQ91OqBnKSWpn/nRS7gAeEgr6bL5pI
H8Gbdy4vQqZlK7FIV0kVR9QW8avnkj7Q4mmLy+f/4Zf4hXmDXrOorz07ymouybcR
FCABsqgIEVMqYj5JdqBoIzoSUWQW0l8gRXAP691kjKFaME9SnhMMt3iLJkIstbMs
8Z96gRy+Wkpur2R1go5Eg3rBRkHRJ/XSkchqNm9G2iy5QIPwDmrM4n8sz0ZM7Ho3
G2CfzeFgUtLBgHQ0cC+el4B/ircucDdZShaFZGdRFS2xULRIhMqb/JmaHd7K5Wf4
pPl7VTBS8Rc=
=XWrP
-----END PGP SIGNATURE-----

--=-8WXs2ordTxhsmS7HleAU--
