Return-Path: <wangbj@lzu.edu.cn>
Received: from eyou.net (unknown [202.201.0.146])
	by ozlabs.org (Postfix) with SMTP id 9EFCBDE1E8
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 22:45:26 +1100 (EST)
Message-ID: <393807068.14207@eyou.net>
From: "Wang, Baojun" <wangbj@lzu.edu.cn>
To: linuxppc-dev@ozlabs.org
Subject: Execute user program in kernel mode?
Date: Tue, 30 Oct 2007 19:45:22 +0800
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11163784.ou6BJbypvC";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200710301945.25313.wangbj@lzu.edu.cn>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart11163784.ou6BJbypvC
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi,

  Is it possible to run user program (statically linked) in kernel mode? fo=
r=20
example the user program entry is 0x10000000, can we call it directly from=
=20
kernel? I've tried many times, but I got the following Error(Oops):

Oops: Exception in kernel mode, sig: 5 [#1]
NIP: 10000094 LR: 10000094 CTR: C001CBF4
REGS: d1072e90 TRAP: 0700   Not tainted  (2.6.19.2-eldk-xm.1.0)
MSR: 00021000 <ME>  CR: 00000000  XER: 00000000
TASK =3D cf31dc70[809385534] '=EF=BF=BD1=EF=BF=BD =EF=BF=BD=CB=B8' THREAD: =
c001ca38
GPR00: 00000000 D1072F40 C0555B70 10000094 C02C41C0 D1066000 10000094 D106C=
000
GPR08: C02CCAE4 D106A000 28000022 00021000 00000000 00000000 00000000 00000=
000
GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000=
000
GPR24: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000=
000
NIP [10000094] 0x10000094
LR [10000094] 0x10000094
Call Trace:
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
Oops: kernel access of bad area, sig: 11 [#2]
NIP: C00598C8 LR: C000A108 CTR: C001C2A4
REGS: d1072060 TRAP: 0300   Not tainted  (2.6.19.2-eldk-xm.1.0)
MSR: 00021000 <ME>  CR: 84000044  XER: 00000000
DAR: 3E20736D, DSISR: 00000000
TASK =3D cf31dc70[809385534] '=EF=BF=BD1=EF=BF=BD =EF=BF=BD=CB=B8' THREAD: =
c001ca38
GPR00: C000A0FC D1072110 CF31DC70 3E207365 3E20736D 00000000 00000000 C0240=
000
GPR08: CF31DD14 D1072000 00021002 C0002038 C001CBE8 00000000 00000000 00000=
000
GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000=
000
GPR24: CF31DD48 00000000 D10721E0 3E20736D 00000000 CF31DD14 CF31DD48 00000=
000
NIP [C00598C8] find_vma+0x24/0x90
LR [C000A108] do_page_fault+0x50/0x3e0
Call Trace:
Instruction dump:
4c9d0020 91230020 4e800020 7c681b79 38600000 4d820020 4800000c 7d2a4b78
48000070 80680008 2f830000 419e001c <80030008> 7f802040 409d0010 80030004
Kernel panic - not syncing: Aiee, killing interrupt handler!
 <0>Rebooting in 180 seconds..


  Does that mean we can not call user space entry code directly, can we?=20

  Regards,
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

--nextPart11163784.ou6BJbypvC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHJxlTIuIOr7tpgg0RAgGmAJ9tzMfl4FUalZ/gtrX3DRFw5B6+9ACdGRns
olCiWUaFYdgzj2Bo9cZbYuE=
=ez2X
-----END PGP SIGNATURE-----

--nextPart11163784.ou6BJbypvC--
