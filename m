Date: Wed, 29 Mar 2000 18:36:54 -0900
From: Ethan Benson <erbenson@alaska.net>
To: "Henry A. Worth" <haworth@ncal.verio.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC and Pismo Powerbook
Message-ID: <20000329183654.D27338@plato.localdomain.local>
References: <200003291920.LAA08359@ shell1.ncal.verio.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
In-Reply-To: <200003291920.LAA08359@ shell1.ncal.verio.com>; from haworth@ncal.verio.com on Wed, Mar 29, 2000 at 11:20:17AM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2000 at 11:20:17AM -0800, Henry A. Worth wrote:
>=20
> I filled 32MB up quite easily with test kernels. Of course
> normal users won't have that problem.  You should=20
> leave enough room for several kernels so you can have a=20
> basic rescue kernel and ramdisk, a good stable kernel, and=20
> that spiffy new kernel that's going to mess everything up
> and require you to use that rescue kernel. Also if you start
> experimenting with the system folder approach you'll be dupping
> yaboot and conf into the system folder.
>=20

kernels do not belong on the HFS boot partition, they belong on the
ext2 root filesystem.  yaboot !=3D bootx it boots the kernels from ext2
bootx does not.
>=20
> Hm, didn't have that problem when I was using that.=20

some don't, when i worked on a similer project we would have multiple
machines with the EXACT same OS version, one would consistently remove
the blessing and boot blocks, the other hardly ever... =20

> You shouldn't need the system folder nonsense if you also set boot-file.
> Which is one of the nice things about this approach if a Linux-only
> system.

people hate messing with OF settings.  deal with it.  that is why i
reccomend a non macos mountable bootstrap partition, with this
configuration you do not need to touch OF.

>=20
> The problem I had with ybin (of course my perpective is someone=20
> trying to debug support for a machine that will not boot and=20
> install Linux yet), is that this has to be done from Linux.

ybin is a linux utility.  macos does not provide the infrstructure for
me to build something similer, it would require a C program, I am not
a macos programmer and don't want to be. =20

> It would be a lot more usefull if it was a MacOS tool

it might be useful to have a macos tool but my goal is to eliminate
the need to do everything from macos, also if you would read the web
page it explains quite clealy that the point of ybin is to provide a
quik/lilo like way to manage a bootstrap partition.  if that is not
what you want then ybin is not for you.

> or you at least had seperate docs, after downloading it I couldn't=20
> unpackage it in MacOS and with no docs decided it wasn't worth=20

tar.gz is hardly difficult to unpackage under macos.  lets leave the
misinformation out please.  there IS docs in the ybin package, not as
much as i would like, but 0.12 will have more. =20

> the trouble to transfer to my x86 system to see what it consisted=20

this is rubbish you don't need to transfer it to a intel system to
unpack it.  you seem to think that macos is only capable of extracting
stuffit archives.=20

> of. Until someone produces some definitative consolidated=20
> documentation for yaBoot and these other tools, so users can plan
> ahead, they are already going to have their system repartioned and=20
> have reinstalled MacOS and install Linux to find out they are going=20
> to have to do it all over again, yeh...right.=20

I happen to be working on documenting all of this, and am more then
halfway there.  if you don't have a bootstrap partition then yes you
have to repartition or keep things on your macos partition. ybin will
allow you to install yaboot to a macos partition, but that
configuration forces you to screw with OF and that is why i don't
reccommend it.  i will not reccomend methods that require fscking with
OF becuase i know people don't want that.

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjjiy9YACgkQJKx7GixEevxL7QCghbKRPNFRYJ0VmUgXoWAe0OTx
MNwAnj9kk61Jpf7Fde71/ybuS2H7bgYf
=E25H
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
