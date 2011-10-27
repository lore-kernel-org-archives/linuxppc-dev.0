Return-Path: <ramamru@gmail.com>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
 [209.85.213.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id EA14D1007D8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2011 15:57:38 +1100 (EST)
Received: by ywp31 with SMTP id 31so2703533ywp.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2011 21:57:32 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 27 Oct 2011 10:27:32 +0530
Message-ID: <CAJ4m0g6vDoT6wy3owmRpJowQrJqMyB0F80y=BBTcBZtzHJUd2A@mail.gmail.com>
Subject: Re: Kdump/kexec for mpc85xx
From: radha krishna <ramamru@gmail.com>
To: McClintock Matthew-B29882 <B29882@freescale.com>
Content-Type: multipart/alternative; boundary=bcaec520f7c537e19304b0409cca
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--bcaec520f7c537e19304b0409cca
Content-Type: text/plain; charset=ISO-8859-1

Hi ,

The subject is changed to "Kdump/kexec for mpc85xx", as i am going to use it
on P2010 and MPC8567 processors as will. So that it will not confuse others
and to continue as a separate topic. In fact, i have selected P2041 which is
e500mc core, for my next project.
Please provide more details on "how to Kdump/kexec for 85xx?". I mean open
source versions of kexec-tools, linux versions, etc....
At preset, i have been using linux-2.6.32 on P2010 based board and ELDK42 as
tool chain.



On Wed, Oct 26, 2011 at 6:27 AM, McClintock Matthew-B29882 <
B29882@freescale.com> wrote:

> On Mon, Oct 24, 2011 at 7:35 AM, radha krishna <ramamru@gmail.com> wrote:
> > Hi Team,
> >
> > I am using Linux-3.0 on mpc8379 RDB. I have downloaded kexec-tools-2.0.2
> > package from open source and cross compiled for ppc_6xx.
> > But, the kexec is not booting with kernel loaded with "kexec -l".
>
> I'm not sure who has tested on 83xx stuff, I've only done 85xx.
>
> -M
>

--bcaec520f7c537e19304b0409cca
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi ,<br><br>The subject is changed to &quot;Kdump/kexec for mpc85xx&quot;, =
as i am going to use it on P2010 and MPC8567 processors as will. So that it=
 will not confuse others and to continue as a separate topic. In fact, i ha=
ve selected P2041 which is e500mc core, for my next project.<br>
Please provide more details on &quot;how to Kdump/kexec for 85xx?&quot;. I =
mean open source versions of kexec-tools, linux versions, etc....<br>At pre=
set, i have been using linux-2.6.32 on P2010 based board and ELDK42 as tool=
 chain.<br>
<br><br><br><div class=3D"gmail_quote">On Wed, Oct 26, 2011 at 6:27 AM, McC=
lintock Matthew-B29882 <span dir=3D"ltr">&lt;<a href=3D"mailto:B29882@frees=
cale.com">B29882@freescale.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid=
 rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">On Mon, Oct 24, 2011 at 7:35 AM, radha krishna &lt;<a hre=
f=3D"mailto:ramamru@gmail.com">ramamru@gmail.com</a>&gt; wrote:<br>
&gt; Hi Team,<br>
&gt;<br>
&gt; I am using Linux-3.0 on mpc8379 RDB. I have downloaded kexec-tools-2.0=
.2<br>
&gt; package from open source and cross compiled for ppc_6xx.<br>
&gt; But, the kexec is not booting with kernel loaded with &quot;kexec -l&q=
uot;.<br>
<br>
</div>I&#39;m not sure who has tested on 83xx stuff, I&#39;ve only done 85x=
x.<br>
<font color=3D"#888888"><br>
-M<br>
</font></blockquote></div><br>

--bcaec520f7c537e19304b0409cca--
