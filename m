Date: Tue, 26 Sep 2000 00:48:46 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: Guillaume Laures <guillaume.laures@noos.fr>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: MacOS X and yaboot wars.
Message-ID: <20000926004845.T1928@plato.local.lan>
References: <20000925145411.G1928@plato.local.lan> <Pine.LNX.4.10.10009261007560.513-100000@opal.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yypaS3FvPkEUiGyo"
In-Reply-To: <Pine.LNX.4.10.10009261007560.513-100000@opal.biophys.uni-duesseldorf.de>; from schmitz@opal.biophys.uni-duesseldorf.de on Tue, Sep 26, 2000 at 10:10:49AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--yypaS3FvPkEUiGyo
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2000 at 10:10:49AM +0200, Michael Schmitz wrote:
>=20
> Does ybin rely on the Apple_Bootstrap type? If not, just call it any way
> you like to make MacOS messing with it even more unlikely.=20

ybin could not care less, ybin will install onto a regular file
happily ;-) =20

what DOES care is OpenFirmware, which insists on it being Apple_Boot*
Apple_Boot is used by apple so macosx will do whatever it wants
whenever it wants, Apple_HFS is out since macos old will ruin it as we
have all seen.  Apple used to use Apple_Booter so i would avoid that too. =
=20

i think the best solution is just reorder the partitions again after
installing OSX.  using Apple_Boot would probably just mean your
partition would be erased instead of moved which is far worse IMO.

> Caution: I've found the reorder option to work in very non-obvious ways
> (partitions could only be moved one way IIRC). I'll have to investigate
> that in more detail.=20

it can be done, but yes i have not totally figured out the right
syntax.

ill see if i can get Clausen to add reorder support to parted if its
not already there.

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--yypaS3FvPkEUiGyo
Content-Type: application/pgp-signature


--yypaS3FvPkEUiGyo--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
