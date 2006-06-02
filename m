Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5441D67B1A
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jun 2006 00:07:15 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC 3/8] snd-aoa: add soundbus
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hu0734qay.wl%tiwai@suse.de>
References: <20060601115844.343214000@sipsolutions.net>
	<20060601115846.852128000@sipsolutions.net>
	<s5hu0734qay.wl%tiwai@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ffYChtELi/7u6/Ory0yl"
Date: Fri, 02 Jun 2006 16:07:05 +0200
Message-Id: <1149257225.11092.22.camel@johannes.berg>
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


--=-ffYChtELi/7u6/Ory0yl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-06-02 at 15:53 +0200, Takashi Iwai wrote:
> > +		int l;
> > +		length +=3D sprintf (buf, "%s\n", compat);
> > +		buf +=3D length;
>=20
> This seems wrong.  The above should be

Heh, no idea where I copied that from but I sure didn't write it myself.
Should be more careful next time I guess :)

> > +	if (strlen(sdev->modalias)) {
> > +		length =3D snprintf (buf, 34, "%s\n", sdev->modalias);
>=20
> sizeof(sdev->modalias) + 2?  But still strange if modalias has no
> nul-end.

Hm, how would I handle that if modalias has no nul?

johannes

--=-ffYChtELi/7u6/Ory0yl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARIBGB6Vg1VMiehFYAQK5ig//cYt9Y2PqTg22PiRjVYOL1q7Bs1r+vDu4
g7RpjrX23008jHFldiBXNLccWjXKou8E+qx2y/nk3Dku0tgt6bxmrISyt0G1veu/
4okDdIkH3KA8t8e0ED2ZLN57sdO6C93HhvyfjaRNK6scpmVIRromGo+JvpF4oa2e
VC+G1/9UqsU8zT3VwmbnnGM5joInxp2FntIswzcRiZ6kDsYW0aHLlo5bs6fVW4Rl
zgyLCE/ddiRFtqHKlswvVgnKv+ZgwBy8h4rANU4T4Mc2KNvQsaTuw4fqHwRE9fxr
Ke70Hp3wF/ctLAIWzjYxjldsdNepsq9xBR5yu6Xcc6jxWH5iYSvOuyFp/xjWDYxQ
fQ0b2e+KGQE3zPRUMIkIKbEZRbtL7JRaDqnr1aLjj5O8loyFHuiXvVAz0phl9qgC
3FYc5COqkzBzb4lh4idfPp+yh6Df/+xyZZl1WaVkVv5bc2JtkNHb7+1HL2eVA3U/
qm1ioK9K487mfKjfS4xyoXqM4U9wKiUi+6mnwzaCaPB60NjPmUiFV3cDLxWfREDW
NXAXNE+Iq5nqoU25TZO6EaDO0QOidyHlspNcwqxU54e5ygPofjZX1mORlSwe0B24
hNdcDJ77AOMqV4QYTt10LCXcNr8tR7AGGbfZd5TxOwknDLiEtVg3KhjdZISQ/dbW
WstcBzBBFw4=
=+SAJ
-----END PGP SIGNATURE-----

--=-ffYChtELi/7u6/Ory0yl--
