Date: Tue, 17 Jul 2001 13:16:48 -0400
From: Ethan Blanton <eblanton@cs.ohiou.edu>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Clock drift on an iBook2
Message-ID: <20010717131648.I22214@localhost.localdomain>
References: <20010717102730.B22214@localhost.localdomain> <20010717165032.5490@smtp.adsl.oleane.com> <20010717130425.G22214@localhost.localdomain> <20010717101420.B2878@opus.bloom.county>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="aqWxf8ydqYKP8htK"
In-Reply-To: <20010717101420.B2878@opus.bloom.county>; from trini@kernel.crashing.org on Tue, Jul 17, 2001 at 10:14:20AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--aqWxf8ydqYKP8htK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Tom Rini spake unto us the following wisdom:
> > Nothing special...   I tried using ntpd to fix the problem, but it
> > didn't seem to be able to set the system time and I'm not sure why.
>=20
> Does your kernel have CONFIG_PPC_RTC enabled? (_not_ CONFIG_RTC).

Yes ... and ntpdate works.
Ethan

--=20
If I've told you once, I've told you once
And once is all that you needed.
		-- The Refreshments, "Carefree"

--aqWxf8ydqYKP8htK
Content-Type: application/pgp-signature
Content-Disposition: inline


--aqWxf8ydqYKP8htK--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
