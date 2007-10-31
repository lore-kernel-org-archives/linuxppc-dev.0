Return-Path: <wangbj@lzu.edu.cn>
Received: from eyou.net (unknown [202.201.0.146])
	by ozlabs.org (Postfix) with SMTP id 57034DE18E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Oct 2007 17:12:26 +1100 (EST)
Message-ID: <393873503.24962@eyou.net>
From: "Wang, Baojun" <wangbj@lzu.edu.cn>
To: linuxppc-embedded@ozlabs.org,
 "Bai Shuwei" <baishuwei@gmail.com>
Subject: Re: ring on PowerPC
Date: Wed, 31 Oct 2007 14:12:34 +0800
References: <393807697.25590@lzu.edu.cn>
In-Reply-To: <393807697.25590@lzu.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2678156.JkQ5VmEuQ0";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200710311412.36584.wangbj@lzu.edu.cn>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart2678156.JkQ5VmEuQ0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 31 October 2007 13:05:16, Bai Shuwei wrote=EF=BC=9A
> Hi, everyone
>    As we know, the program on the X86 can run on the differnt ring(0, 1, =
2,
> 3) and the linux kernel run in the ring 0 and user program in the ring 3.
> And now I want to know wether there is a simple mechanism on the PowerPC
> architecture? thx all!
>
> best regards!
>
> Buroc

powerpc has a machine state register(MSR), bit MSR_PR present the current=20
privilege level, if msr & MSR_PR, then it's from user space, otherwise(msr =
&=20
MSR_PR =3D=3D 0) it's kernel space.

besides, the linux implementation only use ring0 and ring3 under i386, ring=
0=20
is highest(kernel space), ring3 is lowest (userspace)

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

--nextPart2678156.JkQ5VmEuQ0
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHKBzSIuIOr7tpgg0RAv1pAJ4k0CMnqPqUDOSKOH7CIdQ+pvgOZQCfR7KF
zNgZnFp2NnFAzql0A3bdjoA=
=XFw7
-----END PGP SIGNATURE-----

--nextPart2678156.JkQ5VmEuQ0--
