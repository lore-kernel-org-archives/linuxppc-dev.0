Return-Path: <wenlinjing@gmail.com>
Received: from mail-pz0-f195.google.com (mail-pz0-f195.google.com
	[209.85.222.195]) by ozlabs.org (Postfix) with ESMTP id BE162B7D10
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Jan 2010 12:02:48 +1100 (EST)
Received: by pzk33 with SMTP id 33so1406624pzk.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Jan 2010 17:02:47 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 21 Jan 2010 09:02:47 +0800
Message-ID: <b90a809a1001201702y7d42eb60v43f24cb1043a89fa@mail.gmail.com>
Subject: How to trun off udbg0 during bootup?
From: =?UTF-8?B?5pmv5paH5p6X?= <wenlinjing@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=000e0cd1aa10e5b727047da24257
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd1aa10e5b727047da24257
Content-Type: text/plain; charset=UTF-8

Hi,

 I `m working on a freescale-MPC8379eRDB like board.And I want to trun off
kernel message during bootup.

 I tried to  modify "console = XXX" argument in uboot but it did not work(It
works on ARM). Kernel always print:

"console [udbg0] enabled"    or   "console handover: boot [*udbg0*] -> real
[ttyS1]"

Does anybody know how can I turn off this udbg0?


Regards,

jing wenlin

--000e0cd1aa10e5b727047da24257
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>=C2=A0I `m working on a freescale-MPC8379eRDB like board.And I w=
ant to trun off kernel message during bootup.<br><br>=C2=A0I tried to=C2=A0=
 modify &quot;console =3D XXX&quot; argument in uboot but it did not work(I=
t works on ARM). Kernel always print:<br>
<br>&quot;console [udbg0] enabled&quot; =C2=A0=C2=A0 or=C2=A0=C2=A0 &quot;c=
onsole handover: boot [<em>udbg0</em>] -&gt; real [ttyS1]&quot;=C2=A0 <br><=
br>Does anybody know how can I turn off this udbg0?<br><br><br>Regards,<br>=
<br>jing wenlin<br><br>
<br>=C2=A0<br><br><br>

--000e0cd1aa10e5b727047da24257--
