Return-Path: <openspace.wang@gmail.com>
Received: from mail-iy0-f170.google.com (mail-iy0-f170.google.com
 [209.85.210.170]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id EF781B6F67
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Nov 2011 12:05:23 +1100 (EST)
Received: by iakc1 with SMTP id c1so781289iak.15
 for <linuxppc-dev@ozlabs.org>; Wed, 02 Nov 2011 18:05:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4EB197B8.8020504@freescale.com>
References: <CAPxxNQnhXaKJ5ve-=0qwChuuvDj_027RM2pSD43DEf6BZbaHDA@mail.gmail.com>
 <20111101172531.GG16267@us.ibm.com>
 <CAPxxNQ=TkMFhzBeLi9bt5Fo7gygoM2V61EHYRzKqcMetaG2qnQ@mail.gmail.com>
 <4EB197B8.8020504@freescale.com>
Date: Thu, 3 Nov 2011 09:05:21 +0800
Message-ID: <CAPxxNQm6xHciU137i-s2MWAjv-SPCJNx3JX5NuLb7SxneaLomQ@mail.gmail.com>
Subject: Re: What does rmo/tce stand for in powerpc?
From: Ryan Wang <openspace.wang@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: multipart/alternative; boundary=90e6ba1eee6ec3aa6604b0ca2e83
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--90e6ba1eee6ec3aa6604b0ca2e83
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

2011/11/3 Scott Wood <scottwood@freescale.com>

> On 11/02/2011 06:17 AM, Ryan Wang wrote:
> >
> >
> > 2011/11/2 Nishanth Aravamudan <nacc@us.ibm.com <mailto:nacc@us.ibm.com>=
>
> >
> >     Hi Ryan,
> >
> >     On 01.11.2011 [14:25:43 +0800], Ryan Wang wrote:
> >     > Hi,
> >     >
> >     > In kernel source comments, I saw the words:
> >     > ''
> >     >
> >     > alloc_top is set to the top of RMO, eventually shrink down if the
> >     > <http://lxr.linux.no/linux+*/arch/powerpc/kernel/prom_init.c#L972
> >     <http://lxr.linux.no/linux+*/arch/powerpc/kernel/prom_init.c#L972
> >>TCEs
> >     > overlap
> >     >
> >     > ''
> >     >
> >     > I wonder what does RMO mean, and TCE?
> >
> >     RMO =3D Real Mode Offset -- deprecated in terms of Real Mode Area i=
n
> PAPR.
> >
> >     TCE =3D Translation Control Entry
> >
> >     You should be able to find descriptions of both in PAPR.
> >
> >
> > Thanks Nish!
> >
> > But I searched <Power.orgTM Standard for Embedded Power ArchitectureTM
> > Platform Requirements> and failed to found the concept RMO or Real Mode
> > Offset.
> >
> > Will you please give me some hints to the docs=A3=BFThanks,
>
> ePAPR and PAPR are not the same thing.
>
> It looks like PAPR is only available to power.org members.
>

Got it. Thanks, Nish.


>
> -Scott
>
>

--90e6ba1eee6ec3aa6604b0ca2e83
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2011/11/3 Scott Wood <span dir=3D"ltr">&=
lt;<a href=3D"mailto:scottwood@freescale.com">scottwood@freescale.com</a>&g=
t;</span><br><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt=
 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
On 11/02/2011 06:17 AM, Ryan Wang wrote:<br>
&gt;<br>
&gt;<br>
&gt; 2011/11/2 Nishanth Aravamudan &lt;<a href=3D"mailto:nacc@us.ibm.com">n=
acc@us.ibm.com</a> &lt;mailto:<a href=3D"mailto:nacc@us.ibm.com">nacc@us.ib=
m.com</a>&gt;&gt;<br>
<div class=3D"im">&gt;<br>
&gt; &nbsp; &nbsp; Hi Ryan,<br>
&gt;<br>
&gt; &nbsp; &nbsp; On 01.11.2011 [14:25:43 +0800], Ryan Wang wrote:<br>
&gt; &nbsp; &nbsp; &gt; Hi,<br>
&gt; &nbsp; &nbsp; &gt;<br>
&gt; &nbsp; &nbsp; &gt; In kernel source comments, I saw the words:<br>
&gt; &nbsp; &nbsp; &gt; &#39;&#39;<br>
&gt; &nbsp; &nbsp; &gt;<br>
&gt; &nbsp; &nbsp; &gt; alloc_top is set to the top of RMO, eventually shri=
nk down if the<br>
&gt; &nbsp; &nbsp; &gt; &lt;<a href=3D"http://lxr.linux.no/linux+*/arch/pow=
erpc/kernel/prom_init.c#L972" target=3D"_blank">http://lxr.linux.no/linux+*=
/arch/powerpc/kernel/prom_init.c#L972</a><br>
&gt; &nbsp; &nbsp; &lt;<a href=3D"http://lxr.linux.no/linux+*/arch/powerpc/=
kernel/prom_init.c#L972" target=3D"_blank">http://lxr.linux.no/linux+*/arch=
/powerpc/kernel/prom_init.c#L972</a>&gt;&gt;TCEs<br>
&gt; &nbsp; &nbsp; &gt; overlap<br>
&gt; &nbsp; &nbsp; &gt;<br>
&gt; &nbsp; &nbsp; &gt; &#39;&#39;<br>
&gt; &nbsp; &nbsp; &gt;<br>
&gt; &nbsp; &nbsp; &gt; I wonder what does RMO mean, and TCE?<br>
&gt;<br>
&gt; &nbsp; &nbsp; RMO =3D Real Mode Offset -- deprecated in terms of Real =
Mode Area in PAPR.<br>
&gt;<br>
&gt; &nbsp; &nbsp; TCE =3D Translation Control Entry<br>
&gt;<br>
&gt; &nbsp; &nbsp; You should be able to find descriptions of both in PAPR.=
<br>
&gt;<br>
&gt;<br>
&gt; Thanks Nish!<br>
&gt;<br>
&gt; But I searched &lt;Power.orgTM Standard for Embedded Power Architectur=
eTM<br>
&gt; Platform Requirements&gt; and failed to found the concept RMO or Real =
Mode<br>
&gt; Offset.<br>
&gt;<br>
&gt; Will you please give me some hints to the docs=A3=BFThanks,<br>
<br>
</div>ePAPR and PAPR are not the same thing.<br>
<br>
It looks like PAPR is only available to <a href=3D"http://power.org" target=
=3D"_blank">power.org</a> members.<br></blockquote><div><br>Got it. Thanks,=
 Nish.<br>&nbsp;</div><blockquote class=3D"gmail_quote" style=3D"margin: 0p=
t 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1=
ex;">

<font color=3D"#888888"><br>
-Scott<br>
<br>
</font></blockquote></div><br>

--90e6ba1eee6ec3aa6604b0ca2e83--
