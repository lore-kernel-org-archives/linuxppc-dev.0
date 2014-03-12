Return-Path: <tony@bakeyournoodle.com>
Date: Wed, 12 Mar 2014 19:17:07 +1100
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/le: Show the endianess of the LPAR under PowerVM.
Message-ID: <20140312081707.GB13555@thor.bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/platforms/pseries/setup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platform=
s/pseries/setup.c
index 972df0f..5a32caa 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -516,7 +516,11 @@ static void __init pSeries_setup_arch(void)
 static int __init pSeries_init_panel(void)
 {
 	/* Manually leave the kernel version on the panel. */
+#ifdef __BIG_ENDIAN__
 	ppc_md.progress("Linux ppc64\n", 0);
+#else
+	ppc_md.progress("Linux ppc64le\n", 0);
+#endif
 	ppc_md.progress(init_utsname()->version, 0);
=20
 	return 0;
--=20
1.8.5.3


Yours Tony

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJTIBgDAAoJEPvNNsFAAoTB9doQAOmhi3l3yRxWv+4FxbTasVfR
q9caC4RAmnMgJ3el6af7l9xt81+PUFUt63MsQsuGZQ+GdEA4RLRnKbwEyoaF8xvf
DxaFfwvQS7RerWKHjGg67ICRFUTaL+J7DGo9Y/Rn15Xahpa3hfwMS7IO0tVFPyiv
wDX0ysFXQ1a5Wt9ipbdg4yTJR6wmHgaZ3IUscMlrG+30NHJVMqzA/BMti6CLmV4s
6mYN9hAVVJ/ZBXjOQBL0w5lFqdENL19ghwSp4Ci0OKzx9mWoN914GpUPcsko23Wt
+pGDdYvk2SzHnaFisTDS4Ynw/ruqEYvSuUqrYM8wFIY9HuhDSZXkWuFeydDDDJjY
nXabRRRkQP+mBUV5P66SzMqqSrNEJn9n+ATkbPXq5BcNnRcD2PrjFdG2YCSvUKmw
4B2UnXEohXYNiQasauWj5oA86Nb9FewG70UB2PVDesQ+D0MvMqrvm43dUrOR2iWk
/61v+fSihVVYDJtVlqEhs+zNdT92M1OxG3WZfVab0/YytMB8/qetonJegU1hCgTq
c95YTcDizrhYm4NCnBd4ez2+QMmahvwZ4SzGyo3piUbkenVPBwH0bRK8kydaysrr
9IkeUQ/QeGZojZqDe9NYbaCut9wzOHHCNA1hYNu3OGr8ufuLpeAff8SjfFTloifv
/tjUgxQIR5GsdoShWcLx
=hT54
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
