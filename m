Return-Path: <vvijayan@mvista.com>
Received: from mail-ie0-f181.google.com (mail-ie0-f181.google.com
 [209.85.223.181])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9EF021A1F02
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Nov 2014 16:32:12 +1100 (AEDT)
Received: by mail-ie0-f181.google.com with SMTP id rp18so17312468iec.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 21:32:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOpNGcsgX0wVOgMN77+RuKVsb_iHQ7XQk8U_05-up__wC6zuZQ@mail.gmail.com>
References: <1412919926-13123-1-git-send-email-vvijayan@mvista.com>
 <20141015020811.7904E14011B@ozlabs.org>
 <CAOpNGcsgX0wVOgMN77+RuKVsb_iHQ7XQk8U_05-up__wC6zuZQ@mail.gmail.com>
From: Vineeth Vijayan <vvijayan@mvista.com>
Date: Fri, 14 Nov 2014 11:01:50 +0530
Message-ID: <CAOpNGctp-h=mKrXNd1tvzTB+141Zg+xZzaAG02or4SoVh=f2EQ@mail.gmail.com>
Subject: Re: powerpc: Fix Text randomization
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: multipart/alternative; boundary=001a11431a6653fda20507caf3b0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a11431a6653fda20507caf3b0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

ping !

any update on this ? As i understand, only powerpc and s390 uses the
randomize_et_dyn call; for all other architecture this is an obsolete
function call.

this call for another patch where randomize_et_dyn is removed.

Vineeth

On Wed, Oct 15, 2014 at 12:08 PM, Vineeth Vijayan <vvijayan@mvista.com>
wrote:

> On Wed, Oct 15, 2014 at 7:38 AM, Michael Ellerman <mpe@ellerman.id.au>
> wrote:
> > On Fri, 2014-10-10 at 05:45:26 UTC, Vineeth Vijayan wrote:
> >> Right now there is no way to disable TEXT randomization on a PPC32
> >> machine. text randomization happens even in the case of "echo 0 >
> >> /proc/sys/kernel/randomize_va_space"
> >
> > Yeah it seems to happen on ppc64 too.
> >
> >> This happens due to the incorrect definition of ELF_ET_DYN_BASE at
> >> arch/powerpc/include/asm/elf.h
> >
> > What is incorrect about it? We are not the only arch that does that.
> >
>
> I think we are one of the arch which does it.
> The same has been tested on x86 and arm, where ELF_ET_DYN_BASE doesn=E2=
=80=99t
> use randomize_et_dyn call, and it works properly as per the user-space
> definition of randomization;
>
> (i.e when at "echo 0 > /proc/sys/kernel/randomize_va_space", TEXT
> randomization should not happen.)
>
> > I'm not clear on what has changed to break this?
> >
> > cheers
>

--001a11431a6653fda20507caf3b0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>ping !<br><br></div>any update on this ? As i un=
derstand, only powerpc and s390 uses the randomize_et_dyn call; for all oth=
er architecture this is an obsolete function call.<br><br></div><div>this c=
all for another patch where randomize_et_dyn is removed.<br><br></div>Vinee=
th <br></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On W=
ed, Oct 15, 2014 at 12:08 PM, Vineeth Vijayan <span dir=3D"ltr">&lt;<a href=
=3D"mailto:vvijayan@mvista.com" target=3D"_blank">vvijayan@mvista.com</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On Wed,=
 Oct 15, 2014 at 7:38 AM, Michael Ellerman &lt;<a href=3D"mailto:mpe@ellerm=
an.id.au">mpe@ellerman.id.au</a>&gt; wrote:<br>
&gt; On Fri, 2014-10-10 at 05:45:26 UTC, Vineeth Vijayan wrote:<br>
&gt;&gt; Right now there is no way to disable TEXT randomization on a PPC32=
<br>
&gt;&gt; machine. text randomization happens even in the case of &quot;echo=
 0 &gt;<br>
&gt;&gt; /proc/sys/kernel/randomize_va_space&quot;<br>
&gt;<br>
&gt; Yeah it seems to happen on ppc64 too.<br>
&gt;<br>
&gt;&gt; This happens due to the incorrect definition of ELF_ET_DYN_BASE at=
<br>
&gt;&gt; arch/powerpc/include/asm/elf.h<br>
&gt;<br>
&gt; What is incorrect about it? We are not the only arch that does that.<b=
r>
&gt;<br>
<br>
</span>I think we are one of the arch which does it.<br>
The same has been tested on x86 and arm, where ELF_ET_DYN_BASE doesn=E2=80=
=99t<br>
use randomize_et_dyn call, and it works properly as per the user-space<br>
definition of randomization;<br>
<br>
(i.e when at &quot;echo 0 &gt; /proc/sys/kernel/randomize_va_space&quot;, T=
EXT<br>
randomization should not happen.)<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; I&#39;m not clear on what has changed to break this?<br>
&gt;<br>
&gt; cheers<br>
</div></div></blockquote></div><br></div>

--001a11431a6653fda20507caf3b0--
