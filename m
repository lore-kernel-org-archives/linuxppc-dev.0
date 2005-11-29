Return-Path: <otavio@debian.org>
Received: from covilha.procergs.com.br (covilha.procergs.com.br
	[200.198.128.244]) by ozlabs.org (Postfix) with ESMTP id 3ADCC687DE
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2005 05:24:14 +1100 (EST)
From: Otavio Salvador <otavio@debian.org>
To: linuxppc-dev@ozlabs.org
Date: Tue, 29 Nov 2005 15:57:08 -0200
Message-ID: <87fypf8hhn.fsf@nurf.casa>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: debian-powerpc@lists.debian.org
Subject: [PATCH] Export __flush_icache_range since flush_icache_range is
	defined as inline
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Transfer-Encoding: quoted-printable

This change makes MOL work again since it need to use that specific symbol.

Signed-off-by: Otavio Salvador <otavio@debian.org>


=2D--

 arch/powerpc/kernel/ppc_ksyms.c |    2 +-
 arch/ppc/kernel/ppc_ksyms.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

applies-to: 9253bd3b562d6c59044b6175883724f591697da4
b634f3ccf73ca6502b1dd42f372a6ec6bea15ffb
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksym=
s.c
index af4d1bc..2647933 100644
=2D-- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -167,7 +167,7 @@ EXPORT_SYMBOL(giveup_spe);
 EXPORT_SYMBOL(__flush_icache_range);
 #else
 EXPORT_SYMBOL(flush_instruction_cache);
=2DEXPORT_SYMBOL(flush_icache_range);
+EXPORT_SYMBOL(__flush_icache_range);
 EXPORT_SYMBOL(flush_tlb_kernel_range);
 EXPORT_SYMBOL(flush_tlb_page);
 EXPORT_SYMBOL(_tlbie);
diff --git a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
index 66073f7..bb6a5c6 100644
=2D-- a/arch/ppc/kernel/ppc_ksyms.c
+++ b/arch/ppc/kernel/ppc_ksyms.c
@@ -184,7 +184,7 @@ EXPORT_SYMBOL(kernel_thread);
=20
 EXPORT_SYMBOL(flush_instruction_cache);
 EXPORT_SYMBOL(giveup_fpu);
=2DEXPORT_SYMBOL(flush_icache_range);
+EXPORT_SYMBOL(__flush_icache_range);
 EXPORT_SYMBOL(flush_dcache_range);
 EXPORT_SYMBOL(flush_icache_user_range);
 EXPORT_SYMBOL(flush_dcache_page);

=2D-=20
        O T A V I O    S A L V A D O R
=2D--------------------------------------------
 E-mail: otavio@debian.org      UIN: 5906116
 GNU/Linux User: 239058     GPG ID: 49A5F855
 Home Page: http://www.freedom.ind.br/otavio
=2D--------------------------------------------
"Microsoft gives you Windows ... Linux gives
 you the whole house."

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8+ <http://mailcrypt.sourceforge.net/>

iD8DBQFDjJZ3LqiZQEml+FURAo9zAJ9HOKSDVsyiBGRbY4uXn/8DSfc33gCfTC/P
YIjFbK4SGJUt5pRYp8ntpeM=
=k8Ho
-----END PGP MESSAGE-----
--==-=-=--
