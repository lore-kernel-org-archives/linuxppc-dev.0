Date: Tue, 17 Jul 2001 13:32:05 -0400
From: Ethan Blanton <eblanton@cs.ohiou.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Clock drift on an iBook2
Message-ID: <20010717133205.A22391@localhost.localdomain>
References: <20010717165032.5490@smtp.adsl.oleane.com> <20010717165231.25195@smtp.adsl.oleane.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
In-Reply-To: <20010717165231.25195@smtp.adsl.oleane.com>; from benh@kernel.crashing.org on Tue, Jul 17, 2001 at 06:52:31PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Benjamin Herrenschmidt spake unto us the following wisdom:
> Something else you can try: in arch/ppc/kernel/pmac_time.c, comment
> out the call to via_calibrate_decr() (and the return too) so that
> we use the device-tree "timebase-frequency" instead, and tell us if
> it makes any difference.

That seems to have improved it *greatly*.   I know have a drift (only
sampled after a few minutes, so somewhat inaccurate -- but accurate
enough to tell that it's no longer seconds/minute) more on a par with
what I have come to expect.
Ethan

--=20
If I've told you once, I've told you once
And once is all that you needed.
		-- The Refreshments, "Carefree"

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature
Content-Disposition: inline


--xHFwDpU9dbj6ez1V--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
