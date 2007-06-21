Return-Path: <marc.leeman@gmail.com>
Received: from lmailproxy03.edpnet.net (lmailproxy03.edpnet.net [212.71.1.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 823BDDDE29
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 01:56:30 +1000 (EST)
Date: Thu, 21 Jun 2007 17:56:16 +0200
From: Marc Leeman <marc.leeman@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: network load 8245 vs. 8347E
Message-ID: <20070621155616.GR5417@chiana.homelinux.org>
References: <20070621141519.GQ5417@chiana.homelinux.org>
	<0090CCD0-EBB4-4475-BF03-36AF41E2DDA1@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f6M9UaX53EEZorp0"
In-Reply-To: <0090CCD0-EBB4-4475-BF03-36AF41E2DDA1@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: Marc Leeman <marc.leeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--f6M9UaX53EEZorp0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> How are you measuring load?  I'm assuming the 8245 and 8347 are using =20
> the same kernel.

Simply the load of the processor. The 8245 is running ppc/2.6.17, the
8347e is running powerpc/2.6.21.1.

The 8245 kernel is not being upgraded anymore since=20
 1. we're not using them anymore on the new designs
 2. I didn't bother fixing the board support after the interrupt
    handling changed in 2.6.18 because of 1.

Disabling NAPI seems to improve the situation a bit, but there's still a
load difference 25% on a marginally faster processor.

Mem: 10788K used, 116940K free, 0K shrd, 0K buff, 4212K cached
Load average: 0.39 0.43 0.29
  PID USER     STATUS   VSZ  PPID %CPU %MEM COMMAND
  361 barco    SW       152   270 30.8  0.1 recv
 2222 barco    RW      1124   270  0.3  0.8 top
  119 root     SW      1216     1  0.0  0.9 dropbear
  270 barco    SW      1132     1  0.0  0.8 sh
   94 root     SW      1132     1  0.0  0.8 syslogd
    1 root     SW      1128     0  0.0  0.8 init
   95 root     SW      1112     1  0.0  0.8 klogd

Mem: 8144K used, 20944K free, 0K shrd, 888K buff, 2384K cached
Load average: 0.00 0.00 0.00  (Status: S=3Dsleeping R=3Drunning, W=3Dwaitin=
g)
  PID USER     STATUS   RSS  PPID %CPU %MEM COMMAND
  407 barco    R        124     1  6.4  0.4 recv
  510 root     S        668   130  0.7  2.2 dropbear
13889 root     R        368  7377  0.3  1.2 top
  511 barco    S        476   510  0.0  1.6 sh
   52 root     S        376     1  0.0  1.2 syslogd
    1 root     S        352     0  0.0  1.2 init
   59 root     S        340     1  0.0  1.1 klogd


--=20
  greetz, marc
Oh no, no, no, no I don't boogie.
	Crichton - Won't Get Fooled Again
chiana 2.6.18-4-ixp4xx #1 Tue Mar 27 18:01:56 BST 2007 GNU/Linux

--f6M9UaX53EEZorp0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGep+fUQpj09NWLeERAox1AJsFDyUQRbjSdh6kxQS8UZTcFRZfCgCfU9J9
Msbpa3kHhGY7JL/YMN6iiPY=
=uTo0
-----END PGP SIGNATURE-----

--f6M9UaX53EEZorp0--
