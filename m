Date: Wed, 8 Nov 2000 03:24:27 -0900
From: Ethan Benson <erbenson@alaska.net>
To: Steven Hanley <sjh@wibble.net>
Cc: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: how to pass kernel command line arguments?
Message-ID: <20001108032427.Z2367@plato.local.lan>
References: <20001108214245.A31388@wibble.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TX8FgYyhBart40Z+"
In-Reply-To: <20001108214245.A31388@wibble.net>; from sjh@svana.org on Wed, Nov 08, 2000 at 09:42:45PM +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--TX8FgYyhBart40Z+
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2000 at 09:42:45PM +1100, Steven Hanley wrote:
>=20
> All
>=20
> Okay I shall be more specific, how do I pass kernel command line arguments
> (say for example a video=3Dwhatever) to the kernel when booting the kerne=
l on
> the hfs floppy disk image that comes with debian potato. Does anyone know?

hexeditor /mnt/floppy/.resource/System

there is a resource in there somewhere that has the kernel arguments,
ive heard its not too hard to find and edit in a hex editor.
unfortunatly miboot really badly needs a text based configuration file...

> I suspect the .rootinfo may have something to do with the bootup for linu=
x,
> though not sure and I dont know where to find docs on this stuff either.

no .rootinfo is a hfs thing, don't mess with it, all you would likely
end up doing is trashing the filesystem. =20

if you have access to macos and resedit/resourcerer you might find
those simpler to edit the System file.  (beware that MacOS may make
the floppy unbootable if you mount it read-write on macos.  (ive heard
its more forgiving of floppies then disk partitions though, ymmv as
usual))

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--TX8FgYyhBart40Z+
Content-Type: application/pgp-signature


--TX8FgYyhBart40Z+--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
