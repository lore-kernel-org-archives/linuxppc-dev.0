Date: Fri, 9 Feb 2001 14:40:49 +0100
From: Bernhard Reiter <bernhard@intevation.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Stable 2.4.x tree? (network and ppp Problems with Paul's devel)
Message-ID: <20010209144049.A16734@abnoba.intevation.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linuxppc Developers,

for some time now I try to get a recent 2.4.x kernel to work
on my Powerbook (Lombard G3/400MHZ).

2.4.0-test7 runs fine, but with the latest linux-pmac-devel from
rsync ppc.linuxcare.com (Paul Mackeras' tree) I have problem in two
areas:=20
	network: the network sometimes drops out, it can be
	revived	 with a restart of the network=20

	Error Messages: something about NAT dropping untracked messages.
	I have netfilter configured, but no special rules used at all.

	ppp: even with 2.4.0-test7 I have problems with ppp over the
	internal modem.
	I am using pppd-2.4.0 (maybe this is a problem itself)
	Sometimes the connections just hangs for a couple of seconds.
	It is not a provider issue as I encounter this with several
	providers.

	It all runs fine with 2.2.15-pre19.


	ttyS0: If I do not get a connection, the ttyS0 stops working
	after a couple of attempts. Then I cannot open it even with
	minicom (V1.82.1).



If you do not have concrete hints on how to attack my problems,
maybe you can tell me which is a good place to get a newer but
reliable kernel. (I refrain from messing with the proprietory
Bitkeeper stuff.)

And were bugs or difficulties like this can be reported proberly.

Thanks,
	Bernhard

ps.: Please cc relevant replies to me, as I am not subscribed to the
list.

--=20
Professional Service around Free Software                (intevation.net) =
=20
The FreeGIS Project                                         (freegis.org)
Association for a Free Informational Infrastructure            (ffii.org)
FSF Europe                                            	  (fsfeurope.org)

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature
Content-Disposition: inline


--zYM0uCDKw75PZbzx--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
