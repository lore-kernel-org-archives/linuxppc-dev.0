Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5360167AC6
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 22:44:53 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC 2/7] snd-aoa: add aoa core
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hac919jzl.wl%tiwai@suse.de>
References: <20060528190026.754474000@johannes.berg>
	<20060528190124.579130000@johannes.berg> <s5hac919jzl.wl%tiwai@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-wDOrYlhNG7k3O3MhfTmY"
Date: Tue, 30 May 2006 14:44:31 +0200
Message-Id: <1148993072.3102.10.camel@johannes>
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


--=-wDOrYlhNG7k3O3MhfTmY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-05-29 at 12:57 +0200, Takashi Iwai wrote:
> > +	alsa_card =3D snd_card_new(-1, name, mod, sizeof(struct aoa_card));
>=20
> Usually the first argument here is the index module option so that
> user may specify the card order (e.g. secondary card) independent from
> the order of module loading.

Are you saying I should add an index module option and pass that?

johannes

--=-wDOrYlhNG7k3O3MhfTmY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHw+LaVg1VMiehFYAQKs9hAApDarzZ7JMqB6V9e97xqnoKGIh4g3RUqA
T6azyCCmIJUYdhgIpaOVI0byrd2imNbzO29Mmzkd4/OzbaSQxNAlDkW3W0p5QS6X
5KeLFjL7KxQ6tikNZz+LFRBBouDzkB1TpzzObqjV6Ys5A95hSDwerEi0Yy2Pnb2i
SQi4fsbPyksq0bd5XiBLKRUU0hdPokSQaI4d2EJzBx+EM1pwNKQ6oP4VdFNiPiza
GNT7JPWsh8phm0ReglWy0jDGIut8GEvBeMrCApO/2nSrUfq9gSlN2e3meX4LOvom
7Or/NyXOK+H1ObkZ1Sml7Xi1SevqvlQf68Re4C7PTtyhbn7sX/u964By2GqDczT+
r1SHay3JW1fFyV4PpZuXa2PXqxPFy4lv8jJFpcoIb3nViMVY3xvwLJzAXNyQHqMa
EMCHKszBYbZnmlq7YKmGkdhhxV1OJNDP2xFf1fVPkN3GKngPzwycXVEDrqM2PM2u
Nt0YGyc5Wo/t0mr7JEV0NQG9fwKlnR5x/zgFqfF4HnOZITwTBXcbASXrltCxV1IC
/PjlDlIQBNolLwe/HxAjfJ68bzLFSc2q1PkxLz24lYxnpaeTlSmYOuYEE7dbZSe3
kfowcgRUWxEAPFv2pWyZn1gDl02C6becIhaMLQH05tx8oFplPuVTKzf2ejADXEy9
JvD6g195Tcg=
=cwPS
-----END PGP SIGNATURE-----

--=-wDOrYlhNG7k3O3MhfTmY--
