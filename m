Return-Path: <vneethv@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
 [209.85.215.170]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 3F4681007D4
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Dec 2011 22:45:35 +1100 (EST)
Received: by eaai11 with SMTP id i11so1877390eaa.15
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Dec 2011 03:45:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4EE7A776.70609@freescale.com>
References: <CAFbQSaALfZ-6-_g5aC1GgbUaoHyuBwaT342OFMTSf0iqtakDGA@mail.gmail.com>
 <4EE7A776.70609@freescale.com>
From: Vineeth <vneethv@gmail.com>
Date: Thu, 15 Dec 2011 17:15:07 +0530
Message-ID: <CAFbQSaA6yK7d+O0C6-BguKamRcBNnsU-yimO48cQV8G_evmJjw@mail.gmail.com>
Subject: Re: Linux port availability for p5010 processor
To: Scott Wood <scottwood@freescale.com>
Content-Type: multipart/alternative; boundary=000e0ce0f40853b90f04b420051c
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0ce0f40853b90f04b420051c
Content-Type: text/plain; charset=ISO-8859-1

found p5020_ds.c in platforms/85xx;
why is it a part of 85xx directory ? the core of P5020 is E5500 where the
core of 85xx is e500;

Do we have the processor initialization code (start.S, head.S) files, port
available with linux ?





On Wed, Dec 14, 2011 at 12:58 AM, Scott Wood <scottwood@freescale.com>wrote:

> On 12/12/2011 11:33 PM, Vineeth wrote:
> > Do we have a linux port available for freescale P5010 processor (with
> > single E5500 core) ?
> > /(found arch/powerpc/platforms/pseries ; and a some details on
> > kernel/cputable.c /)
>
> p5010 is basically a p5020 with one core and "memory complex" instead of
> two.  The same Linux code should work for both.
>
> pseries is something completely different.
>
> > Is there any reference board which uses this processor ?
>
> p5020ds has a p5020.
>
> Linux support is in arch/powerpc/platforms/85xx/p5020_ds.c (and
> scattered in other places).
>
> > any reference in DTS file also will be helpful.
>
> arch/powerpc/boot/dts/p5020ds.dts
>
> -Scott
>
>

--000e0ce0f40853b90f04b420051c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

found p5020_ds.c in platforms/85xx;<br>why is it a part of 85xx directory ?=
 the core of P5020 is E5500 where the core of 85xx is e500;<br><br>Do we ha=
ve the processor initialization code (start.S, head.S) files, port availabl=
e with linux ? <br>

<br><br><br><br><br><div class=3D"gmail_quote">On Wed, Dec 14, 2011 at 12:5=
8 AM, Scott Wood <span dir=3D"ltr">&lt;<a href=3D"mailto:scottwood@freescal=
e.com">scottwood@freescale.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">

<div class=3D"im">On 12/12/2011 11:33 PM, Vineeth wrote:<br>
&gt; Do we have a linux port available for freescale P5010 processor (with<=
br>
&gt; single E5500 core) ?<br>
</div>&gt; /(found arch/powerpc/platforms/pseries ; and a some details on<b=
r>
&gt; kernel/cputable.c /)<br>
<br>
p5010 is basically a p5020 with one core and &quot;memory complex&quot; ins=
tead of<br>
two. =A0The same Linux code should work for both.<br>
<br>
pseries is something completely different.<br>
<div class=3D"im"><br>
&gt; Is there any reference board which uses this processor ?<br>
<br>
</div>p5020ds has a p5020.<br>
<br>
Linux support is in arch/powerpc/platforms/85xx/p5020_ds.c (and<br>
scattered in other places).<br>
<div class=3D"im"><br>
&gt; any reference in DTS file also will be helpful.<br>
<br>
</div>arch/powerpc/boot/dts/p5020ds.dts<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
-Scott<br>
<br>
</font></span></blockquote></div><br>

--000e0ce0f40853b90f04b420051c--
