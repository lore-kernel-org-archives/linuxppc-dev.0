Date: Sun, 22 Oct 2000 01:10:31 +1100
From: Chris Leishman <masklin@debian.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: linux-pmac-benh broken for some time?
Message-ID: <20001022011031.A4290@nina.dev.fol>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable


Just curious, but is anyone else having this problem on compile of
linux-pmac-benh?

<snip a successful compile...>
ln -sf vmlinux.coff zImage
ld -Ttext 0x00400000 -o vmlinux.elf crt0.o start.o chrpmain.o misc.o string=
.o
zlib.o image.o no_initrd.o /usr/src/linux-pmac-benh/lib/lib.a
=2E/mknote > note
objcopy vmlinux.elf vmlinux.elf --add-section=3D.note=3Dnote -R .comment
objcopy -O aixcoff-rs6000 -R .stab -R .stabstr -R .comment --add-section=3D=
image=3Dvmlinux.gz micoffboot miboot.image
=2E/hack-coff miboot.image
make[1]: Leaving directory `/usr/src/linux-pmac-benh/arch/ppc/coffboot'
make[1]: Entering directory `/usr/src/linux-pmac-benh/arch/ppc/boot'
ld -T ../vmlinux.lds -Ttext 0x00800000 -o zvmlinux.tmp head.o misc.o ../cof=
fboot/zlib.o vreset.o kbd.o of1275.o ns16550.o
vreset.o: In function `vga_init':
vreset.o(.text+0x3c2): undefined reference to `loops_per_jiffy'
vreset.o(.text+0x3c6): undefined reference to `loops_per_jiffy'
make[1]: *** [zvmlinux] Error 1
make[1]: Leaving directory `/usr/src/linux-pmac-benh/arch/ppc/boot'
make: *** [zImage] Error 2


This is with benh's default config.  If this is a problem, is it worth me
trying to track it down, or are you looking at it Ben?

Thanks,

Chris

--=20
----------------------------------------------------------------------
       Knuth: premature optimization is the root of all evil.
----------------------------------------------------------------------
Reply with subject 'request key' for GPG public key.  KeyID 0xB4E24219

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature


--HlL+5n6rz5pIUxbD--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
