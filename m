Return-Path: <noah.yan@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.204])
	by ozlabs.org (Postfix) with ESMTP id 15597685A0
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Oct 2005 23:11:36 +1000 (EST)
Received: by xproxy.gmail.com with SMTP id s17so748665wxc
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Oct 2005 06:11:35 -0700 (PDT)
Message-ID: <59521b110510270605k6e098826w2d37c50e82ddd758@mail.gmail.com>
Date: Thu, 27 Oct 2005 08:05:33 -0500
From: Noah yan <noah.yan@gmail.com>
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_51629_11285647.1130418333041"
Subject: How the linux use BAT
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_51629_11285647.1130418333041
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I am studying source code for power mac. I am curious how linux use the BAT
MMU.
The address translation of BAT MMU is parallel with that of segment/page
MMU. BAT MMU is known as superpages in other architecture.
I am not good at the kernel coding part, hope that my questions share the
common fundermental with you and no stupid.

Here is my questions:
Is the kernel turn BAT MMU on? if so, a BAT array have been setup for that,
which part of the kernel code does this?
If BAT MMU is used, how about segment/page address translation in kernel, i=
s
this also enabled and page table is setup?

If both BAT and seg/page are enabled, how the kernel make sure that the
correct one is used in adress translation?
  Is kernel really use the segment MMU of the powerpc, I have an impression
that most kernel only use the page MMU?


Thanks in advance.

------=_Part_51629_11285647.1130418333041
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>I&nbsp;am studying source code for power mac. I am curious how&nbsp;li=
nux use the BAT MMU. <br>The address translation of BAT MMU is parallel wit=
h that of segment/page MMU. BAT MMU is known as superpages in other archite=
cture.=20
<br>I am not good at the kernel coding part, hope that my questions share t=
he common fundermental with you and no stupid. <br><br>Here&nbsp; is my que=
stions:<br>Is the kernel turn BAT MMU on? if so, a BAT array have been setu=
p for that, which part of the&nbsp;kernel code does this?
<br>If BAT MMU is used, how about segment/page address translation in kerne=
l, is this also enabled and page table is setup? <br><br>If both BAT and se=
g/page are enabled, how the kernel make sure that the correct one is used i=
n adress translation?
</div>
<div>&nbsp;</div>
<div>
<div>Is&nbsp;kernel really use the segment MMU of the powerpc, I have an im=
pression that most kernel only use the page MMU?</div><br><br>Thanks in adv=
ance.<br>&nbsp;</div>

------=_Part_51629_11285647.1130418333041--
