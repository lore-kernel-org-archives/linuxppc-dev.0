Return-Path: <ldv@altlinux.org>
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 40KZ3L07VBzDrZC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 01:29:17 +1000 (AEST)
Date: Mon, 9 Apr 2018 18:22:53 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: ppc compat v4.16 regression: sending SIGTRAP or SIGFPE via kill()
 returns wrong values in si_pid and si_uid
Message-ID: <20180409152253.GD10489@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="J5MfuwkIyy7RmF4Q"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

There seems to be a regression in v4.16 on ppc compat very similar
to sparc compat regression reported earlier at
https://marc.info/?l=3Dlinux-sparc&m=3D151501500704383 .

The symptoms are exactly the same: the same signal_receive test from
the strace test suite fails with the same diagnostics:
https://build.opensuse.org/public/build/home:ldv_alt/openSUSE_Factory_Power=
PC/ppc/strace/_log

Unfortunately, I do not have any means to investigate further,
so just passing this information on to those who care.


--=20
ldv

--J5MfuwkIyy7RmF4Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJay4VNAAoJEAVFT+BVnCUIHsEP/0dzOuE/JsoqDDRsS7s2ZmMT
lazRZD/0abRpsonCGvNoOXm2NtqE9679S1zEmRll7lB+RZKLV3G9YmbtKeOsom7g
YS4j5lQVeHLV+KxqcBLgxUDePGu/pXPQyY8f5cvvB/iSKGqOTe7Yd+mBUii1lu4U
AeW3YxV72atR9Ysw826Zi57FM2XE4XCMtGYFI8QJ3VYDWne/DkbcD7hlqjCzlOwR
pUWddlREy2fQRxwCEGgb/7AfJ+zl0z1ENJ2xxD27EFvI7VfVD8GjFinW3lJlaKF4
zR6V85RwJSshZOiyzgu7MbujX4R7jrH6Ac6s/L5qget7k1LGcsQRFmp62XmpMVJH
A1ptiNBfk1+OMPtFvemPU/FAu9X05/902iakGsZV2hl3JRWyA9bUfmYRBqHXvoMX
7GYAfrGpqKA4A4eNbPC2mjwkdUSRNZa2vI8vop4vttH0MlYjIDGwyEwUCeiOD53p
AnjxPOP4ckslvo7VPbCr2u+PPC5CVhxzPzxULgmUVBs51Iqlak+AwSVv1t/S9uew
Iko3u2Qpxp3aYj7MHXJjNLjquPHz9SJv0xN/ZmfExN4rYseNUrlbmFAkYwLCVzk4
bFrehE0iUz0FyoHKqX91KeVvo+d7SbRox+rRzdVfq546EMrwcpXoiIBATHLPAE8a
k5HLVlm4I1mVfWMFZm0o
=0jiy
-----END PGP SIGNATURE-----

--J5MfuwkIyy7RmF4Q--
