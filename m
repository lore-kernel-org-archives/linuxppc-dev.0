Date: Mon, 16 Oct 2000 15:54:33 -0800
From: Ethan Benson <erbenson@alaska.net>
To: jimix@watson.ibm.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Boot Rom Version and os-chooser
Message-ID: <20001016155433.V29165@plato.local.lan>
References: <14827.34607.795659.155820@kitch0.watson.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WQ40utMgiyDduspJ"
In-Reply-To: <14827.34607.795659.155820@kitch0.watson.ibm.com>; from jimix@pobox.com on Mon, Oct 16, 2000 at 06:54:39PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--WQ40utMgiyDduspJ
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2000 at 06:54:39PM -0400, Jimi X wrote:
>=20
> I updated with Apples PowerBook Firmware Update 2.7 on my pismo as
> apple suggested to fix some firewire kinks I had.
>=20
> Apple System Profiler says:
>   ROM revision:			$t7D.45F6
>   Boot ROM verion:		$0003.27f2
>   Mac OS ROM file version:	3.8

ok..

>=20
> Now my os-chooser forth script does not work.
> I tried adding the obvious "PowerBook3,2" to the <COMPATIBLE>
>=20
> Should I have tried upping the major number?

i highly doubt apple would have changed your machine name with a
firmware upgrade, you can find out what you machine calls itself by
checking /proc/device-tree/compatible, mine looks like so:

PowerMac1,1MacRISCPower Macintosh

only PowerMac1,1 is relevant.  note that my OpenFirmware version is
3.1.1 or something close to that.  the number in the PowerMac name is
not related to the actual firmware revision AFAIK. =20

what forth script are you using?

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--WQ40utMgiyDduspJ
Content-Type: application/pgp-signature


--WQ40utMgiyDduspJ--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
