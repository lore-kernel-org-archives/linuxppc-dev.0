Return-Path: <Horst.KRONSTORFER@frequentis.com>
Received: from webmail.frequentis.com (webmail.frequentis.com [213.47.210.151])
	by ozlabs.org (Postfix) with ESMTP id A1996679F3
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Feb 2006 21:26:34 +1100 (EST)
Subject: [PATCH] Fix BCSR_SIZE for MPC834xSYS
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C63474.13781EC9"
Date: Sat, 18 Feb 2006 11:13:08 +0100
Message-ID: <C5BA91F04186584EB68FD42BB4993E6B5615B5@FRQWOLEX01.frequentis.frq>
From: "KRONSTORFER Horst" <Horst.KRONSTORFER@frequentis.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C63474.13781EC9
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

hi!

according to the 'MPC8349E MDS Processor Board User Manual Rev. 1.6 =
12/2005'
(table 3-1, p. 28) the size of the BCSR mapping is 32kb.

Signed-off-by: Horst Kronstorfer <hkronsto@frequentis.com>

 arch/ppc/platforms/83xx/mpc834x_sys.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/platforms/83xx/mpc834x_sys.h
b/arch/ppc/platforms/83xx/mpc
834x_sys.h
index aa86c22..6727bbd 100644
--- a/arch/ppc/platforms/83xx/mpc834x_sys.h
+++ b/arch/ppc/platforms/83xx/mpc834x_sys.h
@@ -23,7 +23,7 @@
 #define VIRT_IMMRBAR           ((uint)0xfe000000)
=20
 #define BCSR_PHYS_ADDR         ((uint)0xf8000000)
-#define BCSR_SIZE              ((uint)(128 * 1024))
+#define BCSR_SIZE              ((uint)(32 * 1024))
=20
 #define BCSR_MISC_REG2_OFF     0x07
 #define BCSR_MISC_REG2_PORESET 0x01

-h


------_=_NextPart_001_01C63474.13781EC9
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>[PATCH] Fix BCSR_SIZE for MPC834xSYS</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>hi!<BR>
<BR>
according to the 'MPC8349E MDS Processor Board User Manual Rev. 1.6 =
12/2005'<BR>
(table 3-1, p. 28) the size of the BCSR mapping is 32kb.<BR>
<BR>
Signed-off-by: Horst Kronstorfer &lt;hkronsto@frequentis.com&gt;<BR>
<BR>
&nbsp;arch/ppc/platforms/83xx/mpc834x_sys.h |&nbsp;&nbsp;&nbsp; 2 +-<BR>
&nbsp;1 files changed, 1 insertions(+), 1 deletions(-)<BR>
<BR>
diff --git a/arch/ppc/platforms/83xx/mpc834x_sys.h =
b/arch/ppc/platforms/83xx/mpc<BR>
834x_sys.h<BR>
index aa86c22..6727bbd 100644<BR>
--- a/arch/ppc/platforms/83xx/mpc834x_sys.h<BR>
+++ b/arch/ppc/platforms/83xx/mpc834x_sys.h<BR>
@@ -23,7 +23,7 @@<BR>
&nbsp;#define =
VIRT_IMMRBAR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
((uint)0xfe000000)<BR>
<BR>
&nbsp;#define =
BCSR_PHYS_ADDR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
((uint)0xf8000000)<BR>
-#define =
BCSR_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ((uint)(128 * 1024))<BR>
+#define =
BCSR_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ((uint)(32 * 1024))<BR>
<BR>
&nbsp;#define BCSR_MISC_REG2_OFF&nbsp;&nbsp;&nbsp;&nbsp; 0x07<BR>
&nbsp;#define BCSR_MISC_REG2_PORESET 0x01<BR>
<BR>
-h<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C63474.13781EC9--
