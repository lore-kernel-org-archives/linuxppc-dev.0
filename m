Return-Path: <openspace.wang@gmail.com>
Received: from mail-iy0-f170.google.com (mail-iy0-f170.google.com
 [209.85.210.170]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 6A564B6F86
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Nov 2011 22:17:25 +1100 (EST)
Received: by iakc1 with SMTP id c1so12422iak.15
 for <linuxppc-dev@ozlabs.org>; Wed, 02 Nov 2011 04:17:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20111101172531.GG16267@us.ibm.com>
References: <CAPxxNQnhXaKJ5ve-=0qwChuuvDj_027RM2pSD43DEf6BZbaHDA@mail.gmail.com>
 <20111101172531.GG16267@us.ibm.com>
Date: Wed, 2 Nov 2011 19:17:20 +0800
Message-ID: <CAPxxNQ=TkMFhzBeLi9bt5Fo7gygoM2V61EHYRzKqcMetaG2qnQ@mail.gmail.com>
Subject: Re: What does rmo/tce stand for in powerpc?
From: Ryan Wang <openspace.wang@gmail.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Content-Type: multipart/alternative; boundary=90e6ba6e89d690714b04b0be9ddb
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--90e6ba6e89d690714b04b0be9ddb
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

2011/11/2 Nishanth Aravamudan <nacc@us.ibm.com>

> Hi Ryan,
>
> On 01.11.2011 [14:25:43 +0800], Ryan Wang wrote:
> > Hi,
> >
> > In kernel source comments, I saw the words:
> > ''
> >
> > alloc_top is set to the top of RMO, eventually shrink down if the
> > <http://lxr.linux.no/linux+*/arch/powerpc/kernel/prom_init.c#L972>TCEs
> > overlap
> >
> > ''
> >
> > I wonder what does RMO mean, and TCE?
>
> RMO =3D Real Mode Offset -- deprecated in terms of Real Mode Area in PAPR=
.
>
> TCE =3D Translation Control Entry
>
> You should be able to find descriptions of both in PAPR.
>

Thanks Nish!

But I searched <Power.orgTM Standard for Embedded Power ArchitectureTM
Platform Requirements> and failed to found the concept RMO or Real Mode
Offset.

Will you please give me some hints to the docs=A3=BFThanks,



>
> Thanks,
> Nish
>
> --
> Nishanth Aravamudan <nacc@us.ibm.com>
> IBM Linux Technology Center
>
>

--90e6ba6e89d690714b04b0be9ddb
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2011/11/2 Nishanth Aravamudan <span dir=
=3D"ltr">&lt;<a href=3D"mailto:nacc@us.ibm.com">nacc@us.ibm.com</a>&gt;</sp=
an><br><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex=
; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
Hi Ryan,<br>
<div class=3D"im"><br>
On 01.11.2011 [14:25:43 +0800], Ryan Wang wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; In kernel source comments, I saw the words:<br>
&gt; &#39;&#39;<br>
&gt;<br>
&gt; alloc_top is set to the top of RMO, eventually shrink down if the<br>
</div>&gt; &lt;<a href=3D"http://lxr.linux.no/linux+*/arch/powerpc/kernel/p=
rom_init.c#L972" target=3D"_blank">http://lxr.linux.no/linux+*/arch/powerpc=
/kernel/prom_init.c#L972</a>&gt;TCEs<br>
<div class=3D"im">&gt; overlap<br>
&gt;<br>
&gt; &#39;&#39;<br>
&gt;<br>
&gt; I wonder what does RMO mean, and TCE?<br>
<br>
</div>RMO =3D Real Mode Offset -- deprecated in terms of Real Mode Area in =
PAPR.<br>
<br>
TCE =3D Translation Control Entry<br>
<br>
You should be able to find descriptions of both in PAPR.<br></blockquote><d=
iv><br>Thanks Nish!<br><br>But I searched &lt;Power.orgTM Standard for Embe=
dded Power ArchitectureTM Platform Requirements&gt; and failed to found the=
 concept RMO or Real Mode Offset.<br>
<br>Will you please give me some hints to the docs=A3=BFThanks,<br><br>&nbs=
p;<br></div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt =
0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<br>
Thanks,<br>
Nish<br>
<font color=3D"#888888"><br>
--<br>
Nishanth Aravamudan &lt;<a href=3D"mailto:nacc@us.ibm.com">nacc@us.ibm.com<=
/a>&gt;<br>
IBM Linux Technology Center<br>
<br>
</font></blockquote></div><br>

--90e6ba6e89d690714b04b0be9ddb--
