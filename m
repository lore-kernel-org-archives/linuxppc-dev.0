Return-Path: <m_dalmas@yahoo.com.br>
Received: from n7.bullet.re3.yahoo.com (n7.bullet.re3.yahoo.com
	[68.142.237.92])
	by bilbo.ozlabs.org (Postfix) with SMTP id 7B260B708C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Jun 2009 09:20:30 +1000 (EST)
Message-ID: <461095.11075.qm@web111310.mail.gq1.yahoo.com>
Date: Fri, 5 Jun 2009 16:20:27 -0700 (PDT)
From: Marcelo Dalmas <m_dalmas@yahoo.com.br>
Subject: Add "mpc5200-simple-platform" to the list of supported boards
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hello,=0A=0AAdding  "mpc5200-simple-platform" to the list of supported boar=
ds allow to use the option "Generic support for simple MPC5200 based boards=
" without patching the kernel. Just set model to "mpc5200-simple-plataform"=
 on your dts file.=0A=0A=0Adiff --git a/arch/powerpc/platforms/52xx/mpc5200=
_simple.c b/arch/powerpc/platforms/52xx/mpc5200_simple.c=0Aindex c31e5b5..a=
2df795 100644=0A--- a/arch/powerpc/platforms/52xx/mpc5200_simple.c=0A+++ b/=
arch/powerpc/platforms/52xx/mpc5200_simple.c=0A@@ -50,6 +50,7 @@ static voi=
d __init mpc5200_simple_setup_arch(void)=0A =0A /* list of the supported bo=
ards */=0A static char *board[] __initdata =3D {=0A+=09"mpc5200-simple-plat=
form",=0A =09"intercontrol,digsy-mtc",=0A =09"phytec,pcm030",=0A =09"phytec=
,pcm032",=0A=0A=0A=0A=0A      Veja quais s=E3o os assuntos do momento no Ya=
hoo! +Buscados=0Ahttp://br.maisbuscados.yahoo.com
