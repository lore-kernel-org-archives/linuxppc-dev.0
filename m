Return-Path: <roman.fietze@telemotive.de>
Received: from mail.telemotive.de (mail.telemotive.de [62.206.149.210])
	by ozlabs.org (Postfix) with ESMTP id C0D3E67B5B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Oct 2006 19:49:20 +1000 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 9B3E630D28
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Oct 2006 11:49:11 +0200 (CEST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: status of mpc52xx with arch=powerpc?
References: <20061018130628.GE6202@localhost.localdomain>
	<528646bc0610180652u2ee8e8b4xe25d555a59a27c85@mail.gmail.com>
	<20061019081337.GF6202@localhost.localdomain>
In-Reply-To: <20061019081337.GF6202@localhost.localdomain>
MIME-Version: 1.0
Message-ID: <200610191149.10873.roman.fietze@telemotive.de>
Date: Thu, 19 Oct 2006 11:49:07 +0200
Content-Type: multipart/signed; boundary="nextPart1882253.B4UWtndt8c";
	protocol="application/pgp-signature"; micalg=pgp-sha1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart1882253.B4UWtndt8c
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

On Thursday 19 October 2006 10:13, Sascha Hauer wrote:

> Could you post your .dts?
> I'm too working on it, so maybe we should stay synchronized. At the
> moment I have nothing but a minimal dts and some .progress() messages.

Could you both double check e.g. with Sylvain Munaut at

  http://246tnt.com/mpc52xx/

There are many drivers (git heads) available already, including IDE,
=46EC, and so on. There's also new BestComm/FEC/IDE code from Dale
=46arnsworth and John Rigby (Freescale) somewhere on the net.

I've already opened my own branch using DENX 2.6 and several patches
from Sylvain, Dale and John and got a first working 2.6 for the
MPC5200 including DMA driven FEC and IDE. Sylvain promised to get in
touch with the 2.6 maintainers to incorporate his changes into vanilla
2.6. I don't know if he still works on that since his server crashed a
few months ago, that's why I didn't do anything about it.


Here's a part of a mail I got from John in 2006-05:

"Sylvain Munaut is working on a different bestcomm patch.  It's much
cleaner and is based on bestcomm code written by Dale Farnsworth.

You can search the mailing list for a pointer to Sylvain's git tree."


I assume that's what I have here, spinning around with 15k for a few
months now.


Roman

=2D-=20
Roman Fietze              Telemotive AG B=FCro M=FChlhausen
Breitwiesen                            73347 M=FChlhausen
Tel.: +49(0)7335/18493-45      http://www.telemotive.de


--nextPart1882253.B4UWtndt8c
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFN0oWp5XY/BK//MIRAmVYAJ4sTHLKrmxtkOOVxB8iyl608qxqXgCeKzW8
gf6YKHrykKcNspPGZ1TWfJY=
=2phT
-----END PGP SIGNATURE-----

--nextPart1882253.B4UWtndt8c--
