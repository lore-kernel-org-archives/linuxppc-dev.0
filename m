Date: Tue, 4 Jul 2000 15:52:03 +1000
From: Chris Leishman <masklin@debian.org>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: Chas Williams <chas@cmf.nrl.navy.mil>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [ANN] New kernels, gmac, airport, usb...
Message-ID: <20000704155203.A8991@freeonline.com.au>
References: <200007031226.e63CQDw25562@ginger.cmf.nrl.navy.mil> <20000703221729.18421@192.168.1.10>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
In-Reply-To: <20000703221729.18421@192.168.1.10>; from bh40@calva.net on Tue, Jul 04, 2000 at 12:17:29AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2000 at 12:17:29AM +0200, Benjamin Herrenschmidt wrote:
<snip>=20
> I got it to work. There was an endian problem in the driver preventing
> using of the WEP mode. It's fixed in version 0.9.2. I also added a module
> param for the key so you don't need iwconfig to set it
>=20
> see ppclinux.apple.com/~benh for updates
>=20
> Ben.
>=20


Ok..got the new driver, and I can confirm it working here.  Yay...free
of wires at last!

Thanks for all your work Ben.

Regards,

Chris


BTW.  Got any good resources I can start with so I can learn my way around
this sort of thing (kernel/drivers/etc)?  Might mean I can help out in=20
future...

--=20
----------------------------------------------------------------------
            Linux, because I'd like to *get there* today
----------------------------------------------------------------------
Reply with subject 'request key' for GPG public key.  KeyID 0xB4E24219

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature
Content-Disposition: inline


--gBBFr7Ir9EOA20Yy--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
