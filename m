Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 739DF67B35
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2006 02:19:05 +1000 (EST)
Subject: Re: 32 bit userland on G5
From: Johannes Berg <johannes@sipsolutions.net>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1150215340.2844.33.camel@hades.cambridge.redhat.com>
References: <1150194348.9208.33.camel@johannes>
	<1150202709.12423.21.camel@hades.cambridge.redhat.com>
	<1150214746.6305.3.camel@johannes>
	<1150215340.2844.33.camel@hades.cambridge.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-at8v8lGVbyJvCtH4H/cR"
Date: Tue, 13 Jun 2006 18:18:58 +0200
Message-Id: <1150215538.6305.10.camel@johannes>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-at8v8lGVbyJvCtH4H/cR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-06-13 at 17:15 +0100, David Woodhouse wrote:

> Nah. It isn't a valid assumption; just as it isn't valid to assume that
> your stack will _always_ be at about 0xbfffffff.=20

Ok.

Just curious though: Why does READ_IMPLIES_EXEC exist at all then?

johannes

--=-at8v8lGVbyJvCtH4H/cR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARI7lcKVg1VMiehFYAQKimA/+LeingEgbrKCk3I1XZPeWr4JsYNyZIxB1
I9oeAOXZpyL36bchLs787QEY+10Cfcc6Oz1jIhlJk5VjG4bBEKxAtAMvnZpktwc0
aKk5xJeL12xB2p3zn3u5p8kLS1N8uFh9D0ThDuAuv1fWMeO1WEekPTtOoVtB7Ljk
l37tbNI4wkSOcaFrd4nFtGkcwaxND17I9wtZvr9rYeK5UheyNX54vIejltcc3Ova
nfebf1Q5fg2xwkrS1XVl7Nsb5dGTtmo9NtiCNb85FuiKMQq97Nx/X9PrbCrJPFKq
LTCczPfrjWUmBQyftgEBr1txNYQ8iJb0qsvbPreIg8fMTQrljvtpc/8q2M2HsbT+
cb87i7wASOLFctgKCMRadYRl8ydpSOKRHQ9QbjOhKPowvayfFB95GMxleuflOEq4
ofi3KmmyPa3YHeZXJaY9VJbv7XCQdtZMBKMt4u1qkGxpWjgyfQiUtkH3+vqfLC72
u6GbL5sfb2M1Mjteha2BfReN87B8/ZNWmkV8h1UCAXgj9gKg+O/6MhHtCuGcj0/A
Aw8qNYbd8gm6M/Lq7k2Ck5Io3gEu3ykyO7urcNipE3GGL3wzZcQVrJngVzVzFJRu
0LlkAecxvJRZczjoBOSKdwr38a79Yvsws1xwQeuaqh6FKmGXcp+Y4gboRgOX2uVP
/CwoL7Pw7gs=
=7uob
-----END PGP SIGNATURE-----

--=-at8v8lGVbyJvCtH4H/cR--
