Date: Wed, 25 Jul 2001 09:39:02 -0400
From: Ethan Blanton <eblanton@cs.ohiou.edu>
To: linuxppc-dev@lists.linuxppc.org, netdev@oss.sgi.com
Subject: airport reset on iBook2
Message-ID: <20010725093902.E2864@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="11Y7aswkeuHtSBEs"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,
I don't know if this is a known problem (I haven't seen it mentioned)
or not, but I'm getting the following error from my Airport card
reasonably often:

Jul 25 09:27:50 localhost kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jul 25 09:27:50 localhost kernel: eth1: Tx timeout! Resetting card.

It carries with it the undesirable consequence that sometimes all
network traffic stalls for anywhere from 1-10 (subjectively) seconds.
This is probably happening on the order of every 3-5 hours, but when
it happens it often happens several times in the span of a few minutes.

I am sending this to linuxppc-dev and netdev, as I don't know whether
this is airport-specific, or orinoco/hermes related.
Ethan

--=20
If I've told you once, I've told you once
And once is all that you needed.
		-- The Refreshments, "Carefree"

--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature
Content-Disposition: inline


--11Y7aswkeuHtSBEs--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
