Date: Tue, 17 Jul 2001 13:04:25 -0400
From: Ethan Blanton <eblanton@cs.ohiou.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Clock drift on an iBook2
Message-ID: <20010717130425.G22214@localhost.localdomain>
References: <20010717102730.B22214@localhost.localdomain> <20010717165032.5490@smtp.adsl.oleane.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Q59ABw34pTSIagmi"
In-Reply-To: <20010717165032.5490@smtp.adsl.oleane.com>; from benh@kernel.crashing.org on Tue, Jul 17, 2001 at 06:50:32PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--Q59ABw34pTSIagmi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Benjamin Herrenschmidt spake unto us the following wisdom:
> >I have a new iBook2 and I'm having *severe* clock drift problems -- on
> >the order of several seconds gained per minute.  I'd like to get this
> >taken care of, and it seems to be a linux problem as OSX appears to
> >have a stable clock.
>=20
> Are you using MOL or do you experience this with nothing special running ?

Nothing special...   I tried using ntpd to fix the problem, but it
didn't seem to be able to set the system time and I'm not sure why.

> Do you have the same issue if you disable powersave_nap (/proc/sys/
> kernel/powersave_nap) ?

Yes, it seems to make no difference.  (~4s of drift in 3 minutes
either way, according to the tests I just did)

> The TB is calibrated using the VIA, if we don't have a correct VIA freque=
ncy
> or if the calibration routine is slightly off, that may also explain the
> problem.

Looking into your next email regarding the VIA...
Ethan

--=20
If I've told you once, I've told you once
And once is all that you needed.
		-- The Refreshments, "Carefree"

--Q59ABw34pTSIagmi
Content-Type: application/pgp-signature
Content-Disposition: inline


--Q59ABw34pTSIagmi--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
