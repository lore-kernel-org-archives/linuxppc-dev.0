Return-Path: <wangbj@lzu.edu.cn>
Received: from eyou.net (unknown [202.201.0.146])
	by ozlabs.org (Postfix) with SMTP id C4E67DDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Nov 2007 12:44:40 +1100 (EST)
Message-ID: <394030244.20640@eyou.net>
From: "Wang, Baojun" <wangbj@lzu.edu.cn>
To: khollan <khollan@daktronics.com>
Subject: Re: serial GDBServer PPC405  problems
Date: Fri, 2 Nov 2007 09:44:50 +0800
References: <393936343.10887@lzu.edu.cn>
In-Reply-To: <393936343.10887@lzu.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart18978577.oU6XN9DWTQ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200711020944.53077.wangbj@lzu.edu.cn>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart18978577.oU6XN9DWTQ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 02 November 2007 00:49:16, khollan wrote=EF=BC=9A
> Hi everyone
> I want to thank everyone for helping with all of my problems so far, you
> have been a great help.
>
> Im trying to get a debug session with gdbserver over a serial connection =
on
> my Xilinx ML410 using a uartlite set at Baud 115200.  When I issue the
> command on the target "./gdbserver /dev/ttyUL1 test" I get this error:
> Remote debugging using /dev/ttyUL1
> readchar: Socet operation on non-socket
> Remote Side has terminated connection.  GDBserver will reopen connection.
>
> This error just repeats until I kill the process.  I know that gdbserver
> works because debugging over TCP works fine.
> Thanks for your help

Your kernel don't have kgdb support? then you need a debugger like bdi2000 =
to=20
debug the kernel.

Wang

=2D-=20
Wang, Baojun =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Lanzhou University
Distributed & Embedded System Lab =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0http://dslab.lzu.edu.cn
School of Information Science and Engeneering =C2=A0 =C2=A0 =C2=A0 =C2=A0wa=
ngbj@lzu.edu.cn
Tianshui South Road 222. Lanzhou 730000 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .P.R.China
Tel:+86-931-8912025 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Fax:+86-931-8912022

--nextPart18978577.oU6XN9DWTQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHKoETIuIOr7tpgg0RArh7AJ4w4eZBwpxug7o7eNpxzzQzUqdU+ACfQS0k
6XouRP3uy8kxUN5sSLSTog0=
=nuyA
-----END PGP SIGNATURE-----

--nextPart18978577.oU6XN9DWTQ--
