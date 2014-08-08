Return-Path: <vneethv@gmail.com>
Received: from mail-we0-x22a.google.com (mail-we0-x22a.google.com
 [IPv6:2a00:1450:400c:c03::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 92E6D1A1281
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Aug 2014 17:22:42 +1000 (EST)
Received: by mail-we0-f170.google.com with SMTP id w62so5183397wes.29
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Aug 2014 00:22:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3e55262eed7c4b6b9e08e8b792d82e7b@CY1PR0301MB0857.namprd03.prod.outlook.com>
References: <CAFbQSaA80pdzXBk2Om4ewGS9FTWc_tPvu9MM596gPc-_B3igVw@mail.gmail.com>
 <3e55262eed7c4b6b9e08e8b792d82e7b@CY1PR0301MB0857.namprd03.prod.outlook.com>
From: Vineeth <vneethv@gmail.com>
Date: Fri, 8 Aug 2014 12:52:16 +0530
Message-ID: <CAFbQSaDSrCff2YJi2Z-b4655NMa6fkk+xLKs3PB6DG8_Lmf+_A@mail.gmail.com>
Subject: Re: T1040QDS warm reboot
To: Priyanka Jain <Priyanka.Jain@freescale.com>
Content-Type: multipart/alternative; boundary=f46d04138d31d263f30500191161
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--f46d04138d31d263f30500191161
Content-Type: text/plain; charset=UTF-8

Again, warm-reboot WORKS. there's no issue with that.
My ONLY concern is i am not able to understand how it works; the ref.manual
information and the code doesnt match.

Vineeth


On Fri, Aug 8, 2014 at 12:35 PM, Priyanka Jain <Priyanka.Jain@freescale.com>
wrote:

>  Thanks Vineeth for pointing this.
>
>
>
> We will check this on T1040QDS and get back.
>
>
>
>
>
> Regards
>
> Priyanka
>
>
>
> *From:* Linuxppc-dev [mailto:linuxppc-dev-bounces+priyanka.jain=
> freescale.com@lists.ozlabs.org] *On Behalf Of *Vineeth
> *Sent:* Friday, August 08, 2014 11:35 AM
> *To:* linuxppc-dev@lists.ozlabs.org
> *Subject:* T1040QDS warm reboot
>
>
>
> Was wondering how "reboot" works from linux kernel for t1040qds.
>
> When checked, @arch/powerpc/sysdev/fsl_soc.c
>
> __setup_rstcr, an ioremap is done for the offset 0xb0 and writes 0x2 to
> that to reboot the machine. and it works properly.
>
> when checked the reference manual for T1040QDS, it was given that RST_CTL
> is at offset 0x40 and the RST is the 7th bit of same.
>
> then how's has-rstcr/reboot works ?
>
> Vineeth
>
>
>
>
>

--f46d04138d31d263f30500191161
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Again, warm-reboot WORKS. there&#39;s no issue with t=
hat.<br></div>My ONLY concern is i am not able to understand how it works; =
the ref.manual information and the code doesnt match.<br><br>Vineeth<br></d=
iv>

<div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Fri, Aug 8=
, 2014 at 12:35 PM, Priyanka Jain <span dir=3D"ltr">&lt;<a href=3D"mailto:P=
riyanka.Jain@freescale.com" target=3D"_blank">Priyanka.Jain@freescale.com</=
a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">





<div link=3D"#0563C1" vlink=3D"#954F72" lang=3D"EN-US">
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d">Thanks Vineeth for pointi=
ng this.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=A0<u></u></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d">We will check this on T10=
40QDS and get back.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=A0<u></u></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=A0<u></u></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d">Regards<u></u><u></u></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d">Priyanka<u></u><u></u></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=A0<u></u></spa=
n></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;"> Linuxp=
pc-dev [mailto:<a href=3D"mailto:linuxppc-dev-bounces%2Bpriyanka.jain" targ=
et=3D"_blank">linuxppc-dev-bounces+priyanka.jain</a>=3D<a href=3D"mailto:fr=
eescale.com@lists.ozlabs.org" target=3D"_blank">freescale.com@lists.ozlabs.=
org</a>]
<b>On Behalf Of </b>Vineeth<br>
<b>Sent:</b> Friday, August 08, 2014 11:35 AM<br>
<b>To:</b> <a href=3D"mailto:linuxppc-dev@lists.ozlabs.org" target=3D"_blan=
k">linuxppc-dev@lists.ozlabs.org</a><br>
<b>Subject:</b> T1040QDS warm reboot<u></u><u></u></span></p><div><div clas=
s=3D"h5">
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Was wondering how &qu=
ot;reboot&quot; works from linux kernel for t1040qds.<u></u><u></u></p>
</div>
<p class=3D"MsoNormal">When checked, @arch/powerpc/sysdev/fsl_soc.c <u></u>=
<u></u></p>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">__setup_rstcr, an ior=
emap is done for the offset 0xb0 and writes 0x2 to that to reboot the machi=
ne. and it works properly.<u></u><u></u></p>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">when checked the refe=
rence manual for T1040QDS, it was given that RST_CTL is at offset 0x40 and =
the RST is the 7th bit of same.
<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">then how&#39;s has-rs=
tcr/reboot works ?<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Vineeth<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
</div></div></div>
</div>

</blockquote></div><br></div>

--f46d04138d31d263f30500191161--
