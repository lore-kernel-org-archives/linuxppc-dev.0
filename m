Date: Mon, 10 Jul 2000 19:13:07 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Nelson Abramson <pogtal@erols.com>
Cc: "Michael A. Peters" <moonglue@141.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: yaBoot and Standard Tree
Message-ID: <20000710191307.H7162@plato.local.lan>
References: <v04220801b58f50178265@[192.168.0.2]> <3969DF97.AA660A2A@erols.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O5Id/BeFYSryHlds"
In-Reply-To: <3969DF97.AA660A2A@erols.com>; from pogtal@erols.com on Mon, Jul 10, 2000 at 10:37:11AM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--O5Id/BeFYSryHlds
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2000 at 10:37:11AM -0400, Nelson Abramson wrote:
>=20
> "Michael A. Peters" wrote:
>=20
> > Are there patches to the standard 2.2 tree (2.2.16 specifically) that
> > would allow those standard kernels to work with yaBoot?
>=20
> The kernel should have nothing to do with the bootloader, in this case
> yaboot.  Check out the yaboot FAQ if you are having problems getting it
> to work: http://www.linuxppc.org/ybin/doc/yaboot-faq.html

actually 2.2.16 from ftp.kernel.org (the Linus tree) is broken on
newworlds, perhaps 2.2.17 will have all the PPC stuff merged but until
then there is still ALOT of patching needed.  paul's rsync tree is
still the one to use on newworlds.=20

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--O5Id/BeFYSryHlds
Content-Type: application/pgp-signature


--O5Id/BeFYSryHlds--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
