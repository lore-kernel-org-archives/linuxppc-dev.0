Date: Mon, 25 Sep 2000 05:23:31 -0800
From: Ethan Benson <erbenson@alaska.net>
To: johnathan spectre <jspectre@lords.com>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: latest nvsetenv?
Message-ID: <20000925052331.B1928@plato.local.lan>
References: <B5F4C557.2241%jspectre@lords.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
In-Reply-To: <B5F4C557.2241%jspectre@lords.com>; from jspectre@lords.com on Mon, Sep 25, 2000 at 09:03:19AM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2000 at 09:03:19AM -0400, johnathan spectre wrote:
>=20
> hi everyone,
>=20
> I'm having some problems with ybin, one of them being a complaint that I
> don't have the latest version of nvsetenv.

you can add `nonvram' to /etc/yaboot.conf to shut that up, its just a
warning though, you can ignore it ;-)

> Can someone point me out to where I can find the latest version? I looked=
 on
> a few sites and search engines and can't find it.

the latest powerpc-utils package in potato-proposed-updates has it.  i
think the souce is in users/hollis on ftp.penguinppc.org.  not sure on
that though..

> Thanks!
>=20
> -js
>=20
> ps. if anyone can help with ybin I'd appreciate it, I'm getting the
> following error when it tries to copy to my boot partition:
[snip]
> ybin: Copying /usr/local/lib/yaboot/yaboot to /dev/hda8...
> hcopy: Current HFS directory "linuxppc::" no longer exists
> hcopy: "/usr/local/lib/yaboot/yaboot": can't find parent directory
> (Input/output error)
> ybin: An error occured while copying files to /dev/hda8

uhhh, this is weird, you don't have your bootstrap partition mounted
anywhere do you?  also try deleting the ~/.hcwd file before running
ybin, it may contain something bogus.=20

the other possibility is you don't have a valid HFS filesystem on the
bootstrap partition, you can run mkofboot instead of ybin to erase and
create a new filesystem before installing the bootstrap. =20

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature


--+pHx0qQiF2pBVqBT--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
