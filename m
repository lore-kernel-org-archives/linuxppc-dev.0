Date: Wed, 25 Oct 2000 11:22:20 -0400
From: Josh Huber <huber@mclx.com>
To: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: powerbook pcmcia troubles
Message-ID: <20001025112219.C14268@missioncriticallinux.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm having some problems with pcmcia on my powerbook.  I've got a
Wallstreet and pcmcia is working fine with this, but on my new
powerbook things aren't so good.

Here is the relevant card services start up:

Linux PCMCIA Card Services 3.1.21
  kernel build: 2.2.18pre15-ben1 unknown
  options:  [pci] [cardbus]
Intel PCIC probe:
  TI 1211 rev 00 PCI-to-CardBus at slot 00:13, mem 0x80880000
     host opts [0]: [serial pci & irq] [pci irq 22] [lat 32/176] [bus 32/34]
     PCI irq 22 test failed
     *NO* card interrupts, polling interval =3D 1000 ms

On card insert (a flash memory card, in this case), I get:
cs: memory probe 0x90000000-0x90ffffff: clean.
ide_cs: RequestIRQ: Resource in use

Any ideas why no card interrupts could be found?

Thanks,

--=20
Josh
| huber@mclx.com |
1024D/6B21489A 61F0 6138 BE7B FEBF A223  E9D1 BFE1 2065 6B21 489A

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature
Content-Disposition: inline


--mvpLiMfbWzRoNl4x--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
