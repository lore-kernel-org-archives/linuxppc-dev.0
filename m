Date: Sun, 28 May 2000 06:47:28 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Henning Loeser <Henning.Loeser@Physik.Uni-Marburg.DE>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ide_dmaproc - YaBoot
Message-ID: <20000528064728.K29071@plato.local.lan>
References: <20000528061224.I29071@plato.local.lan> <Pine.OSF.4.02.10005281623430.24781-100000@ax1305.physik.uni-marburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="74hf9PSALuoWtOh/"
In-Reply-To: <Pine.OSF.4.02.10005281623430.24781-100000@ax1305.physik.uni-marburg.de>; from Henning.Loeser@Physik.Uni-Marburg.DE on Sun, May 28, 2000 at 04:35:13PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--74hf9PSALuoWtOh/
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Sun, May 28, 2000 at 04:35:13PM +0200, Henning Loeser wrote:
>=20
> Well beeing lazy I would only do that if it does promise some progress in
> getting the card to work. I'll see what I can find out about quik, but
> maybe I have to give it a try to find out ... :-(

quik is annoyingly not well documented, the only docs you can find are
very old and unmaintained... =20

the old docs are still somewhat accurate, only things i ignore is the
thing about putting kernel arguments and such in the boot-file OF
variable, just write a correct quik.conf and you don't need to fiddle
with that.  i helped someone over irc setup quik successfully on a
7200 (though it won't boot 2.2.15 only 2.2.14, still haven't figured
that out...) but someone else who tried the same thing on another 7200
(with same quik sources) just gets DEFAULT CATCH!=20

i can't say i have ever setup quik personally (just through irc ;-)  i
don't have any oldworld macs (except a powerbook 540c that is quite
opposed to me putting any sort of *nix on it)=20

> Something else seems to be fishy aswell maybe the driver (???) or
> whatever. I went ahead and tried a new 2.4.0test1-ac1 kernel and all of
> the sudden the driver doesn't even see the drive any more ... :
> AEC6260R: IDE controller on PCI bus 00 dev 68
> AEC6260R: chipset revision 1
> AEC6260R: not 100% native mode: will probe irqs later
> AEC6260R: ROM enabled at 0x80810000
> AEC6260: reg49h=3D0x00 ATA-66 Cable Port0
>     ide0: BM-DMA at 0x0800-0x0807, BIOS settings: hda:pio, hdb:pio
> AEC6260: reg49h=3D0x00 ATA-66 Cable Port1
>     ide1: BM-DMA at 0x0808-0x080f, BIOS settings: hdc:pio, hdd:pio
> hda: ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ, ATA DISK drive
 =20
what the devil is all that ZZZZZZZZ crap???

> ide0 at 0x840-0x847,0x000 on irq 23
> hda: 187353000 sectors (95925 MB) w/11565KiB Cache, CHS=3D23130/90/90
> hda: INVALID GEOMETRY: 90 PHYSICAL HEADS?

hmm 95925MB, wow thats a nice disk you got there ;-) =20

there is obviously something seriously bogus going on there, its
coming up with total crap for specs on the drive...

> and then doesn't even enable the drive. I emailed that to Andre Hedrick to
> see whether he knows whats going on.

ill bet it don't enable the drive ;-) =20

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--74hf9PSALuoWtOh/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjkxMYAACgkQJKx7GixEevxJywCeIDjPK6MbLsDzEdjQE+MU6uMa
L1kAoIv/s5xitCaIA1NF8R7ZkVIxPWyU
=NC/c
-----END PGP SIGNATURE-----

--74hf9PSALuoWtOh/--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
