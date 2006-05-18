Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C9AB367A04
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 20:13:21 +1000 (EST)
Subject: Re: snd-aoa status update / automatic driver loading
From: Johannes Berg <johannes@sipsolutions.net>
To: Wolfgang Pfeiffer <roto@gmx.net>
In-Reply-To: <20060517221945.GA2902@localhost>
References: <1147860564.14395.6.camel@johannes>
	<20060517215412.GA4504@localhost>  <20060517221945.GA2902@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-K5wByc/4Uk8zVZqHWiyO"
Date: Thu, 18 May 2006 12:13:12 +0200
Message-Id: <1147947192.15507.40.camel@johannes>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-K5wByc/4Uk8zVZqHWiyO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-05-18 at 00:19 +0200, Wolfgang Pfeiffer wrote:

> changed /etc/modules to explicitly load only i2sbus:

Even that should not be necessary.

johannes

--=-K5wByc/4Uk8zVZqHWiyO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARGxItqVg1VMiehFYAQJE1w/8CdPoTs3EgPO8pu2y7kEh9ySpf99VZ6SC
DJTBsOF+5NGx6y+pR4zM6pNu0JJA5fO1eK4AmiXE8cPWwcChS/meJBbajfynRqP7
dfvCG6UPxgK+LNbur/S8psmwF7FILoVniFyDeL/JdYAkzcksHKFdXiry28wKlG01
0cPi4FwfmrcZJMcaKvBaSgcJaEr78GJkg0BzoCtY4lt7is4tykKlqo71hCAh2zIP
VoI0mIMPGKQxLYmLv1U2nfjG9U6X9X7/7a6SuM5GTeepZaEDL7/S5PHSPQuFyJLo
Nonxmj4qPYsjufGBkZnRBTCY9rkocHgK4qd//kTae2K9ms5dl89oYY+NOCUuRgLd
mueuiKgFOXvUy1ZszVX9ZR3yDUCOIfIjfiaXyY999a1zJagEY+WJrBW1uuyF1NND
UZVOJOz/6dgN6XXYhAI94Escw7ox9RFWyPyxNRTs2mznQ+ieMpIiF8ETLj5PnNSg
AP0ArYzvXZioyW8DbMRDVxJR7zU0RMUAcpq2ZCJmJ6no51JtNNVstJeSJfMXLIVM
Gt9Njzf0A5UkGvcyvxhMGVwRuAPPCB5293DcZpw9rmZeJTZTadOUgEYRkLfPRQly
urdIbrsN+sbtWQpkgn7Kt+q1thrcD9OWN2+kGoCtgNfmqzbU45zMOzp6/w+9floi
vhiklJtSZZQ=
=I3Tt
-----END PGP SIGNATURE-----

--=-K5wByc/4Uk8zVZqHWiyO--
