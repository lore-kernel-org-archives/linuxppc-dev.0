Date: Sun, 15 Jul 2001 17:15:08 -0400
From: Ethan Blanton <eblanton@cs.ohiou.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Internal airport card not working? (2.4.6-benh)
Message-ID: <20010715171508.B20595@localhost.localdomain>
References: <20010715170446.A20595@localhost.localdomain> <20010715210832.9850@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
In-Reply-To: <20010715210832.9850@smtp.wanadoo.fr>; from benh@kernel.crashing.org on Sun, Jul 15, 2001 at 11:08:32PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Benjamin Herrenschmidt spake unto us the following wisdom:
> >Everything *acts* like it's working, it just doesn't.  If that makes
> >sense.  :-)
>=20
> Not much for now, I suspect a problem with the card's power up sequence
> which may not wait long enough for the card to be up...
>=20
> Do you see anything wrong with packets emitted by the card ?

Unfortunately I didn't pay enough attention at the time to what was
going wrong, I wound up fixing it (by removing/reinserting the driver
stack) before I took any detailed debugging info.

If it does it again on Monday (next time I'll be on that network) I'll
take some dumps and see what I can find.

This network is a little weird anyway, so I'm not *sure* it's the
card's fault entirely...  It's a "local mobility" mobile IP network.
I'm not 100% clear on how it works, but I know it plays some kludgey
voodoo to get mobile IP working *without* the host computer being
aware it is roaming.
Ethan

--=20
If I've told you once, I've told you once
And once is all that you needed.
		-- The Refreshments, "Carefree"

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature
Content-Disposition: inline


--cmJC7u66zC7hs+87--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
