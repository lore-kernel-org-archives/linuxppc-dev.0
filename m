Date: Mon, 25 Sep 2000 14:54:11 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Guillaume Laures <guillaume.laures@noos.fr>
Cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: MacOS X and yaboot wars.
Message-ID: <20000925145411.G1928@plato.local.lan>
References: <20000921214002.N30638@plato.local.lan> <19340817093546.32417@mailhost.mipsys.com> <20000922175444.P30638@plato.local.lan> <39CFE49F.DB1E05EE@noos.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oXNgvKVxGWJ0RPMJ"
In-Reply-To: <39CFE49F.DB1E05EE@noos.fr>; from guillaume.laures@noos.fr on Mon, Sep 25, 2000 at 11:49:51PM +0000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--oXNgvKVxGWJ0RPMJ
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2000 at 11:49:51PM +0000, Guillaume Laures wrote:
>=20
> Yes it does.
> Another weird thing is that it mounts the bootstrap partition.
> But it doesn't unbless anything. And triple-boot works perfectly.
> I just had to mess around with partition # (and btw I seem to have 3 free
> partition disappear).

you should be able to reorder this so your bootstrap partition is first.

[snip]

>=20
> It's a 27G disk...
> May be I'll change "Apple_Bootstrap" to "Apple_Boot" ?

i wouldn't then MOSX will think that its it owns this partition and
who know what it will do to it then.  if its Apple_Bootstrap its less
likely apple will destroy it randomly since OSX does not know what it
is.

i very much doubt they reorder the partition table at every boot so
using the `r' command in mac-fdisk should allow you to reorder the
table so Apple_Bootstrap is first.

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--oXNgvKVxGWJ0RPMJ
Content-Type: application/pgp-signature


--oXNgvKVxGWJ0RPMJ--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
