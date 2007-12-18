Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F2301DDE04
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 23:40:49 +1100 (EST)
Subject: Re: [PATCH] Fix sleep on powerbook 3400
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18277.49950.354034.86146@cargo.ozlabs.ibm.com>
	(sfid-20071217_003100_592270_1EC20FC0)
References: <18277.49950.354034.86146@cargo.ozlabs.ibm.com>
	(sfid-20071217_003100_592270_1EC20FC0)
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-pSueZfVKMnGEWH5Fi7fO"
Date: Tue, 18 Dec 2007 12:28:42 +0100
Message-Id: <1197977322.4885.109.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-pSueZfVKMnGEWH5Fi7fO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Sleep on the powerbook 3400 has been broken since the change that made
> powerbook_sleep_3400 call pmac_suspend_devices(), which disables
> interrupts.  There are a couple of loops in powerbook_sleep_3400 that
> depend on interrupts being enabled, and in fact it has to have
> interrupts enabled at the point of going to sleep since it is an
> interrupt from the PMU that wakes it up.

Do you want me to rebase my patches on top of this?

johannes

--=-pSueZfVKMnGEWH5Fi7fO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR2eu6aVg1VMiehFYAQJjIA//S8KMNMHtN0IvW8rVzglF3/Xidk4OiRX2
Hbwdh2TEjKRwknBjx8fT+PIZIS1cqtqy17WTpKfCsnLIPdavulvlFzrkCaMO4SqV
Q9ryZzNTfOgKlXBjFWxviiiA5Ki7t6upqYJh7RTCeGrYL3CbFRfnvKq0ifi0T5DW
gh0aT0WOTCpc2Q/EhRYUP84BziiYTt+aarbIkiN5R4SUvt7qs/ecPb+FE4dIsBFr
u1F1+85uQFQL6ThVcI2DtdAgZdfaUtU/y62CqUpfpfSfFLKCIYjRVg9HzD9WwMfu
vudGeYAtuV2QN260Q6Z/Wqxif/QsT4I0EC4wF5QmWSd+pPwt3kgkKecG2KMhYOxZ
kcOQgjCYujk9xGJkfGdBMw3h8e1DgP9GAQa+dFaxO2uAhXD0+dQQus4xvdH2QJG+
dUrXpo7fhN/0xOTjNJx6HMDtz0SjCtQ/HPcy1a9cGwYEB8wmHFtydsqmUAuEj56p
XXYawpxfebZLylv3CkC6RNvPiXRJNLNtvQcILEPMGrdh+sN75Nl7BU0L+WttEsZ3
tD2WCsdRA4oYf67q1lDeArf+MgvmquwkLW7aB/i3pP+50C7ofwAfGjvqdhKwwwcY
ArMrklNAFISWPSkKVyQxZTJVjSXqGeH6jsr/Z0Iveaz454d4mbnpFVNx8YGDA0lk
vqgKvsN7UcI=
=LiaT
-----END PGP SIGNATURE-----

--=-pSueZfVKMnGEWH5Fi7fO--
