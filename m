Return-Path: <mrahul.krishnan@gmail.com>
Received: from mail-ua0-x241.google.com (mail-ua0-x241.google.com
 [IPv6:2607:f8b0:400c:c08::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzpms0pCyzDqVx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2017 01:58:53 +1100 (AEDT)
Received: by mail-ua0-x241.google.com with SMTP id i68so1801385uad.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 06:58:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170111205514.GI14532@bhelgaas-glaptop.roam.corp.google.com>
References: <20161224093800.GA24893@rahul>
 <20170111205514.GI14532@bhelgaas-glaptop.roam.corp.google.com>
From: Rahul Krishnan <mrahul.krishnan@gmail.com>
Date: Thu, 12 Jan 2017 20:28:50 +0530
Message-ID: <CABHns=AiPJWjeuQBU=N-iyZucS4Qh84=gHM-kt90X7fBSKY5-A@mail.gmail.com>
Subject: Re: [PATCH v2] pci: hotplug: This patch removes unnecessary return
 statement using spatch tool
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary=001a114952ee82abc70545e6f4bc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a114952ee82abc70545e6f4bc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2017 at 2:25 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Sat, Dec 24, 2016 at 03:08:00PM +0530, Rahul Krishnan wrote:
> >
> > This patch removes unnecessary return statement using spatch tool
> >
> > Signed-off-by: Rahul Krishnan <mrahul.krishnan@gmail.com>
>
> Applied to pci/hotplug for v4.11 with Tyrel's Reviewed-by, thanks!
>
> Are there other similar instances elsewhere in drivers/pci?  If so,
> can you fix them all at once?
>
=E2=80=8B
    Yes, I will look into it immediately. Thank you=E2=80=8B


>
> > ---
> >  drivers/pci/hotplug/rpadlpar_core.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/
> rpadlpar_core.c
> > index dc67f39..78ce2c7 100644
> > --- a/drivers/pci/hotplug/rpadlpar_core.c
> > +++ b/drivers/pci/hotplug/rpadlpar_core.c
> > @@ -455,7 +455,6 @@ static inline int is_dlpar_capable(void)
> >
> >  int __init rpadlpar_io_init(void)
> >  {
> > -     int rc =3D 0;
> >
> >       if (!is_dlpar_capable()) {
> >               printk(KERN_WARNING "%s: partition not DLPAR capable\n",
> > @@ -463,8 +462,7 @@ int __init rpadlpar_io_init(void)
> >               return -EPERM;
> >       }
> >
> > -     rc =3D dlpar_sysfs_init();
> > -     return rc;
> > +     return dlpar_sysfs_init();
> >  }
> >
> >  void rpadlpar_io_exit(void)
> > --
> > 2.7.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



--=20
We all know Linux is great... it does infinite loops in 5 seconds.
- Linus Torvald



Regards,

Rahul Krishnan
<https://github.com/rahulkde>Wordpress
<https://rahulkrishnanlive.wordpress.com/>

--001a114952ee82abc70545e6f4bc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:small;colo=
r:#000000"><br></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Thu, Jan 12, 2017 at 2:25 AM, Bjorn Helgaas <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:helgaas@kernel.org" target=3D"_blank">helgaas@kernel.org</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On S=
at, Dec 24, 2016 at 03:08:00PM +0530, Rahul Krishnan wrote:<br>
&gt;<br>
&gt; This patch removes unnecessary return statement using spatch tool<br>
&gt;<br>
&gt; Signed-off-by: Rahul Krishnan &lt;<a href=3D"mailto:mrahul.krishnan@gm=
ail.com">mrahul.krishnan@gmail.com</a>&gt;<br>
<br>
</span>Applied to pci/hotplug for v4.11 with Tyrel&#39;s Reviewed-by, thank=
s!<br>
<br>
Are there other similar instances elsewhere in drivers/pci?=C2=A0 If so,<br=
>
can you fix them all at once?<br></blockquote><div><div style=3D"font-size:=
small;color:rgb(0,0,0);display:inline" class=3D"gmail_default">=E2=80=8B=C2=
=A0=C2=A0 <br></div><div style=3D"font-size:small;color:rgb(0,0,0);display:=
inline" class=3D"gmail_default">=C2=A0=C2=A0=C2=A0 Yes, I will look into it=
 immediately. Thank you=E2=80=8B</div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; ---<br>
&gt;=C2=A0 drivers/pci/hotplug/rpadlpar_<wbr>core.c | 4 +---<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/pci/hotplug/<wbr>rpadlpar_core.c b/drivers/pci/ho=
tplug/<wbr>rpadlpar_core.c<br>
&gt; index dc67f39..78ce2c7 100644<br>
&gt; --- a/drivers/pci/hotplug/<wbr>rpadlpar_core.c<br>
&gt; +++ b/drivers/pci/hotplug/<wbr>rpadlpar_core.c<br>
&gt; @@ -455,7 +455,6 @@ static inline int is_dlpar_capable(void)<br>
&gt;<br>
&gt;=C2=A0 int __init rpadlpar_io_init(void)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0int rc =3D 0;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!is_dlpar_capable()) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_WARN=
ING &quot;%s: partition not DLPAR capable\n&quot;,<br>
&gt; @@ -463,8 +462,7 @@ int __init rpadlpar_io_init(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EPERM;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0rc =3D dlpar_sysfs_init();<br>
&gt; -=C2=A0 =C2=A0 =C2=A0return rc;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return dlpar_sysfs_init();<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 void rpadlpar_io_exit(void)<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe linux-p=
ci&quot; in<br>
&gt; the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">=
majordomo@vger.kernel.org</a><br>
&gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordo=
mo-info.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/<=
wbr>majordomo-info.html</a><br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br><div clas=
s=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><=
div><div dir=3D"ltr"><div>We all know Linux is great... it does infinite lo=
ops in 5 seconds.<br>
- Linus Torvald<blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex"><br></blockquote><br></div><bloc=
kquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">Regards,<br></blockquote>Rahul Krishnan<br><a href=
=3D"https://github.com/rahulkde" target=3D"_blank"></a><a href=3D"https://r=
ahulkrishnanlive.wordpress.com/" target=3D"_blank">Wordpress</a> <br></div>=
</div></div></div>
</div></div>

--001a114952ee82abc70545e6f4bc--
