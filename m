Date: Fri, 20 Apr 2001 15:52:43 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: yaboot issues
Message-ID: <20010420155243.K6381@plato.local.lan>
References: <F81VnkB4ltFlmmlQ0800000f76a@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Se9Fau8C8gEtdaPx"
In-Reply-To: <F81VnkB4ltFlmmlQ0800000f76a@hotmail.com>; from vile8@hotmail.com on Fri, Apr 20, 2001 at 10:11:54PM +0000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--Se9Fau8C8gEtdaPx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2001 at 10:11:54PM +0000, James McD wrote:
>=20
> Well, I cant find any docs on this so Im turning here for help.
> I have a dual g4 533 machine. If I set it up the way I have read
> I have a 100 meg HFS standard partition. Then I have 3 linux_svr partitio=
ns
> each a couple gigs for /home and /. Then I have a
> linux_svr parition for swap. Then another hfs standard for mac os.
> This of course puts me into the 12 parition range. I assume that is norma=
l.

you should setup an 800K type Apple_Bootstrap partition. =20

> My dilemna is this. I can boot off the cd, I can install. Then I can use =
the
> cd to boot a cd kernel and fire up the machine by specifying root. Howeve=
r,
> after copying the same files which are on the cd to
> the boot partition, yaboot comes up from the hard drive....but does not b=
oot
> a kernel. It says
> trying kernel: j_carr
> Sound familiar to anyone?

sounds like your using the broken linuxppc yaboot.  try the mainline
yaboot from penguinppc.org/~benh or /usr/ybin/yaboot/

yaboot-faq: http://penguinppc.org/usr/ybin/doc/yaboot-faq.shtml
partitioning: http://penguinppc.org/usr/ybin/doc/mac-fdisk-basics.shtml
ybin (yaboot installer): http://penguinppc.org/usr/ybin/

> Help. It appears yaboot doesnt play well with this machine.

the mainline yaboot works fine on that machine, i have helped several
people get it working.  try a different distribution. =20

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--Se9Fau8C8gEtdaPx
Content-Type: application/pgp-signature
Content-Disposition: inline


--Se9Fau8C8gEtdaPx--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
