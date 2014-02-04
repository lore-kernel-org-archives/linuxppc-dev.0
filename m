Return-Path: <john.d@servergy.com>
Received: from mail-ob0-f176.google.com (mail-ob0-f176.google.com
 [209.85.214.176])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C66932C0097
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Feb 2014 09:45:29 +1100 (EST)
Received: by mail-ob0-f176.google.com with SMTP id gq1so10318852obb.35
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Feb 2014 14:45:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1391552655.6733.184.camel@snotra.buserror.net>
References: <CAGtOQbSJeJ85Nj-M2XB+w3p5+PTVWrpsFKZqCbEqZYkwsa0GGg@mail.gmail.com>
 <1391552655.6733.184.camel@snotra.buserror.net>
Date: Tue, 4 Feb 2014 16:45:25 -0600
Message-ID: <CAGtOQbRKZLzeup58X8rHz4YiF244TrkRXTqNv_57vEu2Rs8UNg@mail.gmail.com>
Subject: Re: Oops on shutdown : 3.11.0-5-powerpc-e500mc Ubuntu
From: John Donnelly <john.d@servergy.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: multipart/alternative; boundary=089e013a18226b5c6b04f19c65df
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--089e013a18226b5c6b04f19c65df
Content-Type: text/plain; charset=ISO-8859-1

Hi Scott,

 This panic was in the kernel related to NFS  , not u-boot;  Unfortunately
I didn't catch the earlier console message/Oops  but I recall it being
something similar.

 Can you enlighten me what the errata addresses ? I

 I filed the bug here:

https://bugs.launchpad.net/ubuntu/+source/linux-ppc/+bug/1276290





On Tue, Feb 4, 2014 at 4:24 PM, Scott Wood <scottwood@freescale.com> wrote:

> On Tue, 2014-02-04 at 08:47 -0600, John Donnelly wrote:
> >
> >
> >
> >
> > Hi,
> >  Where is a appropriate place to file a bug for this : This is the
> > second occurrence I have seen.
> >
> What U-Boot are you running, and what is the output of its "errata"
> command?  There are some errata (e.g. A-004510) that can cause random
> corruption if you don't have the workaround.
>
> Were both crashes similar (same part of the code, same circumstances)?
>
> -Scott
>
>
>
>


-- 

*Regards,*
* John.*

*--*

*o* Energy-efficiency is #1 reason data centers look to expand.  -- Digital
Realty Trust
*o* Green Data Centers spending to increase 300% worldwide by 2016.  --
Pike Research
*o *Data Centers have become as vital to the functioni
ng of society as power stations.  -- The Economist

--089e013a18226b5c6b04f19c65df
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Scott,<div><br><div>=A0This panic was in the kernel rel=
ated to NFS =A0, not u-boot; =A0Unfortunately I didn&#39;t catch the earlie=
r console message/Oops =A0but I recall it being something similar. =A0 =A0<=
/div><div><br>
</div><div>=A0Can you enlighten me what the errata addresses ? I=A0</div><d=
iv><br></div><div>=A0I filed the bug here:</div><div><br></div><div><a href=
=3D"https://bugs.launchpad.net/ubuntu/+source/linux-ppc/+bug/1276290">https=
://bugs.launchpad.net/ubuntu/+source/linux-ppc/+bug/1276290</a><br>
</div><div>=A0</div><div><br></div><div><br></div></div></div><div class=3D=
"gmail_extra"><br><br><div class=3D"gmail_quote">On Tue, Feb 4, 2014 at 4:2=
4 PM, Scott Wood <span dir=3D"ltr">&lt;<a href=3D"mailto:scottwood@freescal=
e.com" target=3D"_blank">scottwood@freescale.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Tue, 2014-02-04 at 08:4=
7 -0600, John Donnelly wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Hi,<br>
&gt; =A0Where is a appropriate place to file a bug for this : This is the<b=
r>
&gt; second occurrence I have seen.<br>
&gt;<br>
</div>What U-Boot are you running, and what is the output of its &quot;erra=
ta&quot;<br>
command? =A0There are some errata (e.g. A-004510) that can cause random<br>
corruption if you don&#39;t have the workaround.<br>
<br>
Were both crashes similar (same part of the code, same circumstances)?<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
-Scott<br>
<br>
<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div dir=3D"ltr"><div style=3D"font-family:Arial;font-size:12px"><span st=
yle=3D"border-collapse:collapse"><div style=3D"border-collapse:collapse"><d=
iv style=3D"margin:0px;display:inline!important">
<span style=3D"color:rgb(80,0,80);border-collapse:collapse"><font color=3D"=
#67b545"><b><br></b></font></span></div></div><div style=3D"border-collapse=
:collapse"><font color=3D"#67b545"><b>Regards,</b></font></div><div style=
=3D"border-collapse:collapse">
<font color=3D"#67b545"><b>=A0John.</b></font></div><div style=3D"border-co=
llapse:collapse"><font color=3D"#67b545"><b><br></b></font></div><div style=
=3D"border-collapse:collapse"><div style=3D"margin:0px;display:inline!impor=
tant"><span style=3D"color:rgb(80,0,80);border-collapse:collapse"><font col=
or=3D"#67b545"><b>--</b></font></span></div>
</div><div style=3D"border-collapse:collapse"><div style=3D"margin:0px;disp=
lay:inline!important"><span style=3D"color:rgb(80,0,80);border-collapse:col=
lapse"><font color=3D"#67b545"><b><br></b></font></span></div></div><div st=
yle=3D"border-collapse:collapse">
<div style=3D"margin:0px;display:inline!important"><span style=3D"color:rgb=
(80,0,80);border-collapse:collapse"><font color=3D"#67b545"><b>o</b></font>=
=A0</span><span style=3D"border-collapse:collapse"><font color=3D"#000000">=
Energy-efficiency is #1 reason data centers look to expand. =A0-- Digital R=
ealty Trust</font></span></div>
</div><div style=3D"border-collapse:collapse"><div style=3D"margin:0px;disp=
lay:inline!important"><font style=3D"color:rgb(51,204,0)"><b style=3D"color=
:rgb(103,181,69)">o</b>=A0</font><font color=3D"#000000">Green Data Centers=
 spending to increase 300% worldwide by 2016. =A0-- Pike Research</font></d=
iv>
</div></span></div><div style=3D"font-family:Arial;font-size:12px"><div sty=
le=3D"margin:0px"><b style=3D"color:rgb(103,181,69)">o=A0</b><font color=3D=
"#000000">Data Centers have=A0become as vital to the=A0functioni</font><div=
 style=3D"margin:0px;display:inline!important">
<font color=3D"#000000">ng</font><font color=3D"#000000">=A0of society as p=
ower stations. =A0-- The Economist</font></div></div><div style=3D"margin:0=
px"><br></div></div></div>
</div>

--089e013a18226b5c6b04f19c65df--
