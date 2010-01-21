Return-Path: <wenlinjing@gmail.com>
Received: from mail-pz0-f195.google.com (mail-pz0-f195.google.com
	[209.85.222.195]) by ozlabs.org (Postfix) with ESMTP id C3BF2B7C09
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Jan 2010 17:58:30 +1100 (EST)
Received: by pzk33 with SMTP id 33so1621037pzk.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Jan 2010 22:58:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <6A5F574C5A990242B0541891CF955C0D01D1EDBD@CNSHGSMBS05.ad4.ad.alcatel.com>
References: <b90a809a1001201702y7d42eb60v43f24cb1043a89fa@mail.gmail.com>
	<6A5F574C5A990242B0541891CF955C0D01D1EDBD@CNSHGSMBS05.ad4.ad.alcatel.com>
Date: Thu, 21 Jan 2010 14:58:29 +0800
Message-ID: <b90a809a1001202258g2bc2610dw6f24c4d75b49faff@mail.gmail.com>
Subject: Re: How to trun off udbg0 during bootup?
From: =?UTF-8?B?5pmv5paH5p6X?= <wenlinjing@gmail.com>
To: SHAN Gavin <Gavin.Shan@alcatel-lucent.com>
Content-Type: multipart/alternative; boundary=000e0cd13806fa23b4047da73afc
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd13806fa23b4047da73afc
Content-Type: text/plain; charset=UTF-8

2010/1/21 SHAN Gavin <Gavin.Shan@alcatel-lucent.com>

>
>
> Hi,
>
>  I `m working on a freescale-MPC8379eRDB like board.And I want to trun off
> kernel message during bootup.
>
>  I tried to  modify "console = XXX" argument in uboot but it did not
> work(It
> works on ARM). Kernel always print:
>
> "console [udbg0] enabled"    or   "console handover: boot [*udbg0*] -> real
> [ttyS1]"
>
> Does anybody know how can I turn off this udbg0?
>
> You may check arch/powerpc/kernel/udbg.c and disable registering the early
> debug console driver. Then you can not see the output before the message
> line like "-> real [ttyS1]"
>
> Good luck,
> Gavin
>
>   I assigned 1 to "static int early_console_initialized". The driver did
not register early debug console.
It`s worked.

Thank you!

Regards
jing wenlin

--000e0cd13806fa23b4047da73afc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2010/1/21 SHAN Gavin <span dir=3D"ltr">&=
lt;<a href=3D"mailto:Gavin.Shan@alcatel-lucent.com">Gavin.Shan@alcatel-luce=
nt.com</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"border-=
left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left=
: 1ex;">







<div>

<br>

<p><font size=3D"2"><div><div></div><div class=3D"h5"><br>
Hi,<br>
<br>
=C2=A0I `m working on a freescale-MPC8379eRDB like board.And I want to trun=
 off<br>
kernel message during bootup.<br>
<br>
=C2=A0I tried to=C2=A0 modify &quot;console =3D XXX&quot; argument in uboot=
 but it did not work(It<br>
works on ARM). Kernel always print:<br>
<br>
&quot;console [udbg0] enabled&quot;=C2=A0=C2=A0=C2=A0 or=C2=A0=C2=A0 &quot;=
console handover: boot [*udbg0*] -&gt; real<br>
[ttyS1]&quot;<br>
<br>
Does anybody know how can I turn off this udbg0?<br>
<br></div></div>
You may check arch/powerpc/kernel/udbg.c and disable registering the early<=
br>
debug console driver. Then you can not see the output before the message<br=
>
line like &quot;-&gt; real [ttyS1]&quot;<br>
<br>
Good luck,<br>
Gavin<br>
<br>
</font>
</p>

</div>
</blockquote></div>I assigned 1 to &quot;static int early_console_initializ=
ed&quot;. The driver did not register early debug console.<br>It`s worked.<=
br><br>Thank you!<br><br>Regards<br>jing wenlin<br>

--000e0cd13806fa23b4047da73afc--
