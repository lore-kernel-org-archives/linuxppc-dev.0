Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/kdump: Fix /dev/oldmem interface
From: Michael Ellerman <michael@ellerman.id.au>
To: "Sachin P. Sant" <sachinp@in.ibm.com>
In-Reply-To: <489161A4.6060801@in.ibm.com>
References: <489161A4.6060801@in.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-0CmWLCRNYw4h5tvh1fnJ"
Date: Thu, 31 Jul 2008 17:12:37 +1000
Message-Id: <1217488357.1487.51.camel@localhost>
Mime-Version: 1.0
Cc: Vivek Goyal <vgoyal@redhat.com>, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-0CmWLCRNYw4h5tvh1fnJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-07-31 at 12:24 +0530, Sachin P. Sant wrote:
> This patch fixes the /dev/oldmem interface for kdump on ppc64.
> The patch originally came from Michael Ellerman hence have
> retained the signed-off line. I just rediffed/tested against
> latest git. Michael has ack'ed this patch.
>=20
> Ben this is not a must for 2.6.27 but would be good if it's=20
> included.

It's been broken long enough, I think it's a must for 27.


> Signed-off-by : Michael Ellerman <michael@ellerman.id.au>
> Acked-by : Michael Ellerman <michael@ellerman.id.au>

Heh, do I get a prize for being neurotic? ;)  .. Or just stupid, ahem.

I think you should also sign off on it Sachin, see clause (c) of the
developers cert (http://lwn.net/Articles/139918/)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-0CmWLCRNYw4h5tvh1fnJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIkWXldSjSd0sB4dIRAh5KAKDIKtqwrTLxy61XHT8/oaA7a8L8XACbBkWk
c6t9Hi7c6c+qpE2NBtYFZJ8=
=ZCkh
-----END PGP SIGNATURE-----

--=-0CmWLCRNYw4h5tvh1fnJ--
