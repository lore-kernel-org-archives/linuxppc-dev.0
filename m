Date: Sat, 14 Jul 2001 13:12:55 -0400
From: Ethan Blanton <eblanton@cs.ohiou.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Internal airport card not working? (2.4.6-benh)
Message-ID: <20010714131255.A13317@localhost.localdomain>
References: <4.2.2.20010714123138.01d64dc0@mail.inkverse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
In-Reply-To: <4.2.2.20010714123138.01d64dc0@mail.inkverse.com>; from jtr@sourcerers.com on Sat, Jul 14, 2001 at 01:02:17PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jeremy Radlow spake unto us the following wisdom:
> Under 2.4.6 on an iBook, I'm apparently having ARP problems with Airport.=
..
>=20
> When I try to ping other machines on the network, I can see the activity
> lights on my base station and the target machines' ethernet ports, and the
> other machines on my LAN see the airport card in their ARP cache, but the
> laptop with the airport card doesn't get anything in its ARP cache.
>=20
> When I snoop the traffic using tcpdump, all I see is a bunch of spurious =
ARP
> who-has messages originating from the laptop, and is-at messages originat=
ing
> from the target machines.

I'm running BenH's 2.4.6 from about a week ago, and I get similar
behavior...  *eventually* I find the destination and connect or
whatever, but it takes quite a few seconds.

Removing the driver stack (airport, orinoco, hermes) and reinserting
the modules fixes the problem for me...  Until I suspend and resume a
few times, at which point I'll have to remove/reinsert again.

I know that's not a *fix*, but it should get you working again in the
meantime.  :-)
Ethan

--=20
If I've told you once, I've told you once
And once is all that you needed.
		-- The Refreshments, "Carefree"

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature
Content-Disposition: inline


--azLHFNyN32YCQGCU--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
