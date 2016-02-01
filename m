Return-Path: <michael.heltne@gmail.com>
Received: from mail-yk0-x235.google.com (mail-yk0-x235.google.com
 [IPv6:2607:f8b0:4002:c07::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C8EB1A0190
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Feb 2016 07:31:49 +1100 (AEDT)
Received: by mail-yk0-x235.google.com with SMTP id z13so62136295ykd.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Feb 2016 12:31:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJhHMCA6wy=i=yD4S-D0-vRTAOadTbwEtarsawK0BLw23G2Shg@mail.gmail.com>
References: <CANtoAtNkjrJfac0nR7ay7LKToMf53KtpVZNv0+xabHn1QSwRkA@mail.gmail.com>
 <CAJhHMCA6wy=i=yD4S-D0-vRTAOadTbwEtarsawK0BLw23G2Shg@mail.gmail.com>
Date: Mon, 1 Feb 2016 20:31:46 +0000
Message-ID: <CANtoAtNzYXhWQo7jaOMQ7ic0b9+wPsc9QpM1fZxKk3P8+utE7Q@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Failure_on_latest_GIT_=2D_implicit_declaration_of_?=
 =?UTF-8?Q?function_=E2=80=98pte=5Fswp=5Fclear=5Fsoft=5Fdirty=E2=80=99?=
From: Mike <michael.heltne@gmail.com>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
Content-Type: multipart/alternative; boundary=94eb2c0a912218216b052abb46b7
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--94eb2c0a912218216b052abb46b7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thanks!

Applied and it built this time, sadly i missed RC-2 and will just have to
test and see if the radeon r300 is un-broken and rebuild, doing dpkg kernel
build and was lazy with the .config so it takes a day building on this
single core g4!

Cheers
Mike

On 1 February 2016 at 01:05, Pranith Kumar <bobby.prani@gmail.com> wrote:

> On Sun, Jan 31, 2016 at 8:01 PM, Mike <michael.heltne@gmail.com> wrote:
> > Building on ppc32
> >
> > In file included from fs/proc/task_mmu.c:14:0:
> > include/linux/swapops.h: In function =E2=80=98pte_to_swp_entry=E2=80=99=
:
> > include/linux/swapops.h:69:6: error: implicit declaration of function
> > =E2=80=98pte_swp_soft_dirty=E2=80=99 [-Werror=3Dimplicit-function-decla=
ration]
> >   if (pte_swp_soft_dirty(pte))
> >       ^
> > include/linux/swapops.h:70:9: error: implicit declaration of function
> > =E2=80=98pte_swp_clear_soft_dirty=E2=80=99 [-Werror=3Dimplicit-function=
-declaration]
> >    pte =3D pte_swp_clear_soft_dirty(pte);
> >          ^
>
> Can you try the patch posted here: https://lkml.org/lkml/2016/1/25/554
>
> Thanks!
> --
> Pranith
>

--94eb2c0a912218216b052abb46b7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks!=C2=A0<div><br></div><div>Applied and it built this=
 time, sadly i missed RC-2 and will just have to test and see if the radeon=
 r300 is un-broken and rebuild, doing dpkg kernel build and was lazy with t=
he .config so it takes a day building on this single core g4!=C2=A0</div><d=
iv><br></div><div>Cheers</div><div>Mike</div></div><div class=3D"gmail_extr=
a"><br><div class=3D"gmail_quote">On 1 February 2016 at 01:05, Pranith Kuma=
r <span dir=3D"ltr">&lt;<a href=3D"mailto:bobby.prani@gmail.com" target=3D"=
_blank">bobby.prani@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex"><span class=3D"">On Sun, Jan 31, 2016 at 8:01 PM, Mike &lt;<a hr=
ef=3D"mailto:michael.heltne@gmail.com">michael.heltne@gmail.com</a>&gt; wro=
te:<br>
&gt; Building on ppc32<br>
&gt;<br>
&gt; In file included from fs/proc/task_mmu.c:14:0:<br>
&gt; include/linux/swapops.h: In function =E2=80=98pte_to_swp_entry=E2=80=
=99:<br>
&gt; include/linux/swapops.h:69:6: error: implicit declaration of function<=
br>
&gt; =E2=80=98pte_swp_soft_dirty=E2=80=99 [-Werror=3Dimplicit-function-decl=
aration]<br>
&gt;=C2=A0 =C2=A0if (pte_swp_soft_dirty(pte))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>
&gt; include/linux/swapops.h:70:9: error: implicit declaration of function<=
br>
&gt; =E2=80=98pte_swp_clear_soft_dirty=E2=80=99 [-Werror=3Dimplicit-functio=
n-declaration]<br>
&gt;=C2=A0 =C2=A0 pte =3D pte_swp_clear_soft_dirty(pte);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>
<br>
</span>Can you try the patch posted here: <a href=3D"https://lkml.org/lkml/=
2016/1/25/554" rel=3D"noreferrer" target=3D"_blank">https://lkml.org/lkml/2=
016/1/25/554</a><br>
<br>
Thanks!<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
Pranith<br>
</font></span></blockquote></div><br></div>

--94eb2c0a912218216b052abb46b7--
