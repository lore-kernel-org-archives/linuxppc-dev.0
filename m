Date: Mon, 13 Aug 2001 09:38:33 -0400
From: Ethan Blanton <eblanton@cs.ohiou.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Clock drift on iBook2
Message-ID: <20010813093833.B16584@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I just realized that I have committed one of the most common open
source sins...  My problem has been solved and I never reported it!

At any rate, for those who don't remember and may wish to know this, I
was having significant clock drift problems on an iBook2 (up to
several seconds/minute).  Ben Herrenschmidt gave me a quick two-line
patch (comment out the via_calibrate_decr check) which worked...
Since then a real fix seems to have gone in, and it works beautifully.
I no longer have to patch my kernel and the clock is stable.

Thanks.  :-)
Ethan

--=20
If I've told you once, I've told you once
And once is all that you needed.
		-- The Refreshments, "Carefree"

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature
Content-Disposition: inline


--cvVnyQ+4j833TQvp--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
