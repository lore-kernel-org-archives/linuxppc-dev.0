Return-Path: <liranrazlinux@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 605F1DE145
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 06:01:22 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1340907ywb.39
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 12:01:20 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 13 Mar 2009 14:56:02 -0400
Message-ID: <e3b3ab5c0903131156l45ab934fyf7fb33b71468594a@mail.gmail.com>
Subject: node /dev/ttyCPM2 not created
From: liran raz <liranrazlinux@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=00151750d940fb11f9046504a66b
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--00151750d940fb11f9046504a66b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

hi,

I've configured SCC1 to be serial uart driver.
(in addition to SMC1 & SMC2 that were already configured
as UARTs).

Now I can see these defines in .config file:
CONFIG_SERIAL_CPM_SCC1=y
CONFIG_SERIAL_CPM_SMC1=y
CONFIG_SERIAL_CPM_SMC2=y

When the kernal starts I see these log messages:
ttyCPM0 at MMIO 0xc505ca80 (irq = 17) is a CPM UART

ttyCPM1 at MMIO 0xc5060a90 (irq = 16) is a CPM UART

ttyCPM2 at MMIO 0xc5064a00 (irq = 40) is a CPM UART



But when I list the devices:
[root@urm dev]# ll ttyCPM*

crw-rw-rw-    1 root     root     204,  46 Dec 31 17:00 ttyCPM0

crw-rw-rw-    1 root     root     204,  47 Dec 31 17:00 ttyCPM1


I can't see ttyCPM2.

Does anyone know what I'm missing? or what do I need to configure
in order to have: /dev/ttyCPM2 ?

Thanks,
Liran.

--00151750d940fb11f9046504a66b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hi,<br><br>I&#39;ve configured SCC1 to be serial uart driver.<br>(in additi=
on to SMC1 &amp; SMC2 that were already configured<br>as UARTs).<br><br>Now=
 I can see these defines in .config file:<br>CONFIG_SERIAL_CPM_SCC1=3Dy<br>
CONFIG_SERIAL_CPM_SMC1=3Dy<br>CONFIG_SERIAL_CPM_SMC2=3Dy<br><br>When the ke=
rnal starts I see these log messages:<br>ttyCPM0 at MMIO 0xc505ca80 (irq =
=3D 17) is a CPM UART<br><br>ttyCPM1 at MMIO 0xc5060a90 (irq =3D 16) is a C=
PM UART<br>
<br>ttyCPM2 at MMIO 0xc5064a00 (irq =3D 40) is a CPM UART<br><br><br><br>Bu=
t when I list the devices:<br>[root@urm dev]# ll ttyCPM*<br><br>crw-rw-rw-=
=A0=A0=A0 1 root=A0=A0=A0=A0 root=A0=A0=A0=A0 204,=A0 46 Dec 31 17:00 ttyCP=
M0<br><br>crw-rw-rw-=A0=A0=A0 1 root=A0=A0=A0=A0 root=A0=A0=A0=A0 204,=A0 4=
7 Dec 31 17:00 ttyCPM1<br>
<br><br>I can&#39;t see ttyCPM2.<br><br>Does anyone know what I&#39;m missi=
ng? or what do I need to configure<br>in order to have: /dev/ttyCPM2 ?<br><=
br>Thanks,<br>Liran.<br>

--00151750d940fb11f9046504a66b--
