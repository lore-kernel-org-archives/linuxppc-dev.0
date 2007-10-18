Return-Path: <wangbj@lzu.edu.cn>
Received: from eyou.net (unknown [202.201.0.146])
	by ozlabs.org (Postfix) with SMTP id 86197DDDF8
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 13:02:06 +1000 (EST)
Message-ID: <392738361.29285@eyou.net>
From: "Wang, Baojun" <wangbj@lzu.edu.cn>
To: linuxppc-dev@ozlabs.org
Subject: what's inside INT_FRAME_SIZE?
Date: Thu, 18 Oct 2007 10:54:41 +0800
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5716674.Tp40bcobpH";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200710181054.45234.wangbj@lzu.edu.cn>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart5716674.Tp40bcobpH
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi,

  I need setup a stack frame manually under powerpc, sounds like I need=20
prepare at least for size INT_FRAME_SIZE (192 bytes through asm-offset.h),

I know the bottom 176 bytes are for struct pt_regs, how about the upper 16=
=20
(STACK_FRAME_OVERHEAD) bytes? what's inside this 16 bytes? Could you please=
=20
give me some hints? Thanks very much!

  Regards,
Wang
=2D-=20
Wang, Baojun                                        Lanzhou University
Distributed & Embedded System Lab              http://dslab.lzu.edu.cn
School of Information Science and Engeneering        wangbj@lzu.edu.cn
Tianshui South Road 222. Lanzhou 730000                     .P.R.China
Tel:+86-931-8912025                                Fax:+86-931-8912022

--nextPart5716674.Tp40bcobpH
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHFsrxIuIOr7tpgg0RAnRVAJ9S9540BumMu1zVaHgMgwSnk6nF1wCeJFhX
uqg/Gxcxcd5iNVaVEtmLaWQ=
=n5w7
-----END PGP SIGNATURE-----

--nextPart5716674.Tp40bcobpH--
