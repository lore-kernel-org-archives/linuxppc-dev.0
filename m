Date: Wed, 17 May 2000 18:20:00 +0200
From: Claus Enneper <enneper@olis.north.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: quik booting on a wallstreet
Message-ID: <20000517182000.B576@olis.north.de>
Reply-To: cl.en@gmx.net
References: <20000517115301.A332@mclinux.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
In-Reply-To: <20000517115301.A332@mclinux.com>; from Josh Huber on Wed, May 17, 2000 at 11:53:01AM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Description: quik
Content-Transfer-Encoding: quoted-printable

 >:=20
 >: I tried using:
 >: boot-device ide0/disk@0,0 ide0/disk@0:0 ide0/disk@0:11 ide0/disk@0,11
=20
when you are in OF type 'dev alias' and you should see your ata.
something like:
'setenv boot-device ata0/ata-disk@0:B'
remember boot-device wants hex.
 >:=20
 >: My root partition is 11, which has the kernel as well, in /boot/vmlinux.
 >:=20

'setenv boot-file /boot/vmlinux root=3D/dev/hda11

--=20
ce

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v0.9.9 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE5Isawrqjwzwd0UekRAZxEAKChpS1AohLIYH+HMAVbNW9LFxQ83QCbBzRT
lRq8W16OtIp1SyTQonDsAKc=
=zz/8
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
