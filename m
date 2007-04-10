Return-Path: <srinivasa@in.ibm.com>
Received: from ausmtp06.au.ibm.com (ausmtp06.au.ibm.com [202.81.18.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 807E8DDEE2
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 22:51:18 +1000 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp06.au.ibm.com (8.13.8/8.13.8) with ESMTP id l3ACr7bn8159240
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 22:53:07 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.250.237])
	by sd0208e0.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3ACsO7h140482
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 22:54:24 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3ACorIt030153
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 22:50:53 +1000
From: Srinivasa Ds <srinivasa@in.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net, linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: [PATCH] Build break on ppc64 for 2.6.21-rc6-mm1
Date: Tue, 10 Apr 2007 18:20:47 +0530
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ng4GGemdXD+cSQz"
Message-Id: <200704101820.47509.srinivasa@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Boundary-00=_ng4GGemdXD+cSQz
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


When I tried to compile 2.6.21-rc6-mm1 on ppc64, I got the below error=20
message.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
arch/powerpc/sysdev/timer.c:51: error: variable =E2=80=98timer_sysclass=E2=
=80=99 has=20
initializer but incomplete type
arch/powerpc/sysdev/timer.c:52: error: unknown field =E2=80=98resume=E2=80=
=99 specified in=20
initializer
arch/powerpc/sysdev/timer.c:52: warning: excess elements in struct initiali=
zer
arch/powerpc/sysdev/timer.c:52: warning: (near initialization=20
for =E2=80=98timer_sysclass=E2=80=99)
arch/powerpc/sysdev/timer.c:53: error: unknown field =E2=80=98suspend=E2=80=
=99 specified in=20
initializer
arch/powerpc/sysdev/timer.c:53: warning: excess elements in struct initiali=
zer
arch/powerpc/sysdev/timer.c:53: warning: (near initialization=20
for =E2=80=98timer_sysclass=E2=80=99)
arch/powerpc/sysdev/timer.c:54: error: unknown field =E2=80=98kset=E2=80=99=
 specified in=20
initializer
arch/powerpc/sysdev/timer.c:54: error: extra brace group at end of initiali=
zer
arch/powerpc/sysdev/timer.c:54: error: (near initialization=20
for =E2=80=98timer_sysclass=E2=80=99)
arch/powerpc/sysdev/timer.c:54: error: extra brace group at end of initiali=
zer
arch/powerpc/sysdev/timer.c:54: error: (near initialization=20
for =E2=80=98timer_sysclass=E2=80=99)
arch/powerpc/sysdev/timer.c:54: warning: excess elements in struct initiali=
zer
arch/powerpc/sysdev/timer.c:54: warning: (near initialization=20
for =E2=80=98timer_sysclass=E2=80=99)
arch/powerpc/sysdev/timer.c:57: error: variable =E2=80=98device_timer=E2=80=
=99 has initializer=20
but incomplete type
arch/powerpc/sysdev/timer.c:58: error: unknown field =E2=80=98id=E2=80=99 s=
pecified in=20
initializer
arch/powerpc/sysdev/timer.c:58: warning: excess elements in struct initiali=
zer
arch/powerpc/sysdev/timer.c:58: warning: (near initialization=20
for =E2=80=98device_timer=E2=80=99)
arch/powerpc/sysdev/timer.c:59: error: unknown field =E2=80=98cls=E2=80=99 =
specified in=20
initializer
arch/powerpc/sysdev/timer.c:59: warning: excess elements in struct initiali=
zer
arch/powerpc/sysdev/timer.c:59: warning: (near initialization=20
for =E2=80=98device_timer=E2=80=99)
arch/powerpc/sysdev/timer.c: In function =E2=80=98time_init_device=E2=80=99:
arch/powerpc/sysdev/timer.c:64: warning: implicit declaration of=20
function =E2=80=98sysdev_class_register=E2=80=99
arch/powerpc/sysdev/timer.c:66: warning: implicit declaration of=20
function =E2=80=98sysdev_register=E2=80=99
make[1]: *** [arch/powerpc/sysdev/timer.o] Error 1
make: *** [arch/powerpc/sysdev] Error 2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Below patch fixes this problem. please let me know comments on this.

Signed-off-by: Srinivasa Ds <srinivasa@in.ibm.com>


--Boundary-00=_ng4GGemdXD+cSQz
Content-Type: text/x-diff;
  charset="utf-8";
  name="build.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="build.patch"

---
 arch/powerpc/sysdev/timer.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.21-rc6/arch/powerpc/sysdev/timer.c
===================================================================
--- linux-2.6.21-rc6.orig/arch/powerpc/sysdev/timer.c
+++ linux-2.6.21-rc6/arch/powerpc/sysdev/timer.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/time.h>
+#include <linux/sysdev.h>
 #include <asm/rtc.h>
 
 static unsigned long suspend_rtc_time;

--Boundary-00=_ng4GGemdXD+cSQz--
