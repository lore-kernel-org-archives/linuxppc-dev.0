Date: Sat, 28 Jul 2001 00:37:02 -0300
From: Harald Welte <laforge@gnumonks.org>
To: Ethan Blanton <eblanton@cs.ohiou.edu>
Cc: linuxppc-dev@lists.linuxppc.org, netdev@oss.sgi.com
Subject: Re: airport reset on iBook2
Message-ID: <20010728003701.H1240@obroa-skai.gnumonks.org>
References: <20010725093902.E2864@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
In-Reply-To: <20010725093902.E2864@localhost.localdomain>; from eblanton@cs.ohiou.edu on Wed, Jul 25, 2001 at 09:39:02AM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 25, 2001 at 09:39:02AM -0400, Ethan Blanton wrote:

> I don't know if this is a known problem (I haven't seen it mentioned)
> or not, but I'm getting the following error from my Airport card
> reasonably often:
>=20
> Jul 25 09:27:50 localhost kernel: NETDEV WATCHDOG: eth1: transmit timed o=
ut
> Jul 25 09:27:50 localhost kernel: eth1: Tx timeout! Resetting card.

I can confirm that happen from time to time with my Sony VAIO picturebook
C1XD and a Lucent WaveLAN/IEEE board.

unloading the whole pcmcia subsystem (incl. yenta_socket) and re-loading
everything helps.

(kernel 2.4.7)

> I am sending this to linuxppc-dev and netdev, as I don't know whether
> this is airport-specific, or orinoco/hermes related.

well, my platform is non-ppc, and non-airport, so this seems to be a hint
of it being a generic problem.

> Ethan

--=20
Live long and prosper
- Harald Welte / laforge@gnumonks.org                http://www.gnumonks.org
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M-=
=20
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature
Content-Disposition: inline


--Q68bSM7Ycu6FN28Q--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
