Date: Thu, 6 Jul 2000 21:41:45 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Matt Brubeck <mbrubeck@hmc.edu>
Cc: Iain Sandoe <iain@sandoe.co.uk>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Multi-boot advice.
Message-ID: <20000706214145.R7162@plato.local.lan>
References: <200007052323.AAA07099@hyperion.valhalla.net> <Pine.GSO.4.21.0007060751390.17224-100000@turing.cs.hmc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iUdyFHenu1vPh/Ml"
In-Reply-To: <Pine.GSO.4.21.0007060751390.17224-100000@turing.cs.hmc.edu>; from mbrubeck@hmc.edu on Thu, Jul 06, 2000 at 07:57:13AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--iUdyFHenu1vPh/Ml
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2000 at 07:57:13AM -0700, Matt Brubeck wrote:
>=20
> On Thu, 6 Jul 2000, Iain Sandoe wrote:
>=20
> > I think I read that I must put the Linux boot partition before the
> > MacOS - X one?
>=20
> If you are using yaboot with an OF-bootable partition (e.g. you are using
> ybin to set up a bootstrap partition), then placing that partition before
> MacOS will allow you to boot Linux by default without changing any open
> firmware settings.

if you use a multiboot script and you place the Apple_Bootstrap
partition first you will always get the boot choice without altering
OF settings.

> Other than that, partition order shouldn't matter.
>=20
> Speaking of yaboot, I have a question. Can yaboot boot MacOS, or can I
> make it exit back to OF without rebooting?

well strictly speaking, no.  yaboot cannot boot anything else, and
once its loaded OpenFirmware is pretty much destroyed.  you can
however use a magicboot script to give you the choice to boot linux or
macos, this scriptloads before yaboot and thus can boot macos. =20

> I'd like to just have my machine always load yaboot, and then use the
> yaboot prompt to choose my OS. But once I'm in yaboot, Linux seems to be
> my only option. Is this true? If so, can it be changed?

yes use a magicboot script.  see the ybin docs.

>=20
>=20

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--iUdyFHenu1vPh/Ml
Content-Type: application/pgp-signature


--iUdyFHenu1vPh/Ml--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
