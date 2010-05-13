Return-Path: <muvarov@gmail.com>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by ozlabs.org (Postfix) with ESMTP id EF8D0B7DF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 May 2010 21:50:16 +1000 (EST)
Received: by wwb24 with SMTP id 24so736794wwb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 May 2010 04:50:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.01.1005130417590.3356@bogon.housecafe.de>
References: <20100511174749.19309.44615.stgit@muvarov>
	<4BEA5726.50806@nerdbynature.de>
	<alpine.DEB.2.01.1005130417590.3356@bogon.housecafe.de>
Date: Thu, 13 May 2010 15:50:13 +0400
Message-ID: <AANLkTik1aRVvqj871qOmGctuP_WjvSFwhU1w4gpJoqp1@mail.gmail.com>
Subject: Re: [PATCH 1/2] Fix kexec on powerpc32
From: Maxim Uvarov <muvarov@gmail.com>
To: Christian Kujau <lists@nerdbynature.de>
Content-Type: multipart/alternative; boundary=0016e6d99b7883ef570486785cc1
Cc: kexec@lists.infradead.org, uvarov@dev.rtsoft.ru,
	linuxppc-dev@lists.ozlabs.org, horms@verge.net.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e6d99b7883ef570486785cc1
Content-Type: text/plain; charset=ISO-8859-1

2010/5/13 Christian Kujau <lists@nerdbynature.de>

> On Wed, 12 May 2010 at 00:22, Christian Kujau wrote:
> > # kexec -e
> > Starting new kernel
> > Bye!
> >
> > ....but then the system just hung there, no more messages, I had to
> > powercycle it.
>
> Are there any debug flags (or kernel options?) I can set, to find out why
> it hangs here? Or does kexec not understand zImages?
>
>
zImage should not work with kexec. Only vmlinux.


> Thanks,
> Christian.
> --
> BOFH excuse #373:
>
> Suspicious pointer corrupted virtual machine
>



-- 
Best regards,
Maxim Uvarov

--0016e6d99b7883ef570486785cc1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2010/5/13 Christian Kujau <span dir=3D"l=
tr">&lt;<a href=3D"mailto:lists@nerdbynature.de">lists@nerdbynature.de</a>&=
gt;</span><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px s=
olid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">On Wed, 12 May 2010 at 00:22, Christian Kujau wrote:<br>
&gt; # kexec -e<br>
&gt; Starting new kernel<br>
&gt; Bye!<br>
&gt;<br>
&gt; ....but then the system just hung there, no more messages, I had to<br=
>
&gt; powercycle it.<br>
<br>
</div>Are there any debug flags (or kernel options?) I can set, to find out=
 why<br>
it hangs here? Or does kexec not understand zImages?<br>
<br></blockquote><div><br>zImage should not work with kexec. Only vmlinux.<=
br>=A0<br></div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px=
 solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Thanks,<br>
Christian.<br>
<font color=3D"#888888">--<br>
BOFH excuse #373:<br>
<br>
Suspicious pointer corrupted virtual machine<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Best regards,<br=
>Maxim Uvarov<br>

--0016e6d99b7883ef570486785cc1--
