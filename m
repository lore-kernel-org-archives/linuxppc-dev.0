Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 518F467AA0
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jun 2006 00:56:16 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC 0/8] snd-aoa: add snd-aoa
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hodxb4o00.wl%tiwai@suse.de>
References: <20060601115844.343214000@sipsolutions.net>
	<s5hodxb4o00.wl%tiwai@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-gZCFBh2hfw8JFcxnaAzT"
Date: Fri, 02 Jun 2006 16:56:05 +0200
Message-Id: <1149260165.11092.32.camel@johannes.berg>
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


--=-gZCFBh2hfw8JFcxnaAzT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-06-02 at 16:43 +0200, Takashi Iwai wrote:

> As already posted, there are small glitches, but it looks otherwise
> good enough to merge.

Right, I'll post updates (also have a few small changes locally)

> Would you like to commit the patches as one changeset or separate?

I guess it doesn't make much sense to commit them in separate changesets
as they depend on each other, I just split it up for making it easier to
review.

> Anyway, please provide a changelog and a signed-off-by line for proper
> commit.

Obviously, but I didn't think that was necessary for review.

Also, what with further development? I have this in a git tree and will
continue using it, should I just push patches regularly?

johannes

--=-gZCFBh2hfw8JFcxnaAzT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIUAwUARIBRg6Vg1VMiehFYAQKRdQ/406DWeYf9ylUFoLdaR6OvLI8fmBggTsGN
3FSsejolaAXR22HeSya/QUMmiRcAB6DZggoKp6t2qq6PQrkQiQoCsu8pvwg2faEi
L81V49Z279xPvMnQdvUitHMZ3zajNEACVBW4RfaYN2vbbjlqjuWRDfKRQUnT+GO7
BcNx9SOwbSVu0IMDdGCG4LsRh5k3nhTpJy57GEZU+p8qAh4Gz3e1Xd2SCwqd+JXQ
/x3HV0BTqk/rzPdj1Dz1KwI9RUd1Pkqt5Xlizv+w99q66To1klTnv+32EPqF0gKc
j3ghqKvHXIrrrFzoj6H4nV4uOTdUBV6TI8+cD0Jcw6Zv4VhPakfVzt+UdU+XJQze
TmPQntBjAwpAmNeI406zDLc0cfpsF+/Vs4LaCibpk7BVEEZmrmsPVjY5HLyffy8+
D6P0lFFP5mzAZCbtWx2c9Qb0SNitgPtBiVx2A9u1HbyIkoc6aoqdAWgi6XjTkwZd
zF9Pb1mcKTE55ZqhwfrY1a2SvsykjijuUkYo4FeGn+DGAuVnXhOPvhYNt1WDfYcy
zSSu37nk9b52DmGnSOWckavwMZB02XDfIvRrItlltPQ/8N12/NOT66j4Y5RY3n3T
9fiRxaDbobz3RD8oCh5Xg+euozdORX44oO6XcgcCAysc6nOCKs+DoqU3wh6uanfA
W1DimntB9g==
=GxjG
-----END PGP SIGNATURE-----

--=-gZCFBh2hfw8JFcxnaAzT--
