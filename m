Date: Sat, 16 Sep 2000 23:51:45 +0200
From: Claus Enneper <cl.en@gmx.net>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: recent fixes in devel tree
Message-ID: <20000916235145.A486@olis.north.de>
Reply-To: cl.en@gmx.net
References: <20000916152035.A517@olis.north.de> <20000916180511.18729@192.168.1.10>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
In-Reply-To: <20000916180511.18729@192.168.1.10>; from bh40@calva.net on Sat, Sep 16, 2000 at 20:05:11 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Benjamin!

 >: > kernel: Call backtrace:
 >: > kernel: C0179E2C C00CFA88 C00F2BCC C0185B00 C00F2FAC C003C310 C000392
 >: > kernel: 0FF8D9A4 1000302C 100015D4 0FF0B69C 00000000
 >: > kernel: Kernel panic: kernel access of bad area pc c00cf34c lr c00cfa=
88
 >: >address 24 tsk pmud/299
 >: >
 >:=20
 >: Can you lookup in System.map where NIP and LR are ? And eventually a bit
 >: of the backtrace ? I'll check on my side if I see something.

I've built it again to be sure and it did not change the situation.

but there's neither 'pc c00cf34c' nor 'lr c00cfa88' in System.map
c00cf060 t pmac_ide_dmaproc
c00cf218 t idepmac_sleep_device
c00cf334 t idepmac_wake_device
c00cf400 t idepmac_sleep_interface
c00cf4e4 t idepmac_wake_interface
c00cf728 t idepmac_notify_sleep
c00cfab0 T ide_dma_intr
c00cfb8c T ide_build_dmatable

?, is this a thinkable setting?
The System.map does not match the kernel..=20
=20
it seems to be better to rsync again and hope.
is linuxppc.org a reliable server or should it be ppc.samba.org? =20



		Claus

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature
Content-Disposition: inline


--UlVJffcvxoiEqYs2--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
