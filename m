Return-Path: <muvarov@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by ozlabs.org (Postfix) with ESMTP id CD2E9B70B9
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Jul 2010 13:59:53 +1000 (EST)
Received: by vws20 with SMTP id 20so3611364vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 26 Jul 2010 20:59:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100727025506.GA1944@verge.net.au>
References: <1279687384-9770-1-git-send-email-msm@freescale.com>
	<20100727025506.GA1944@verge.net.au>
Date: Tue, 27 Jul 2010 07:59:51 +0400
Message-ID: <AANLkTin_e7twax5Ci683eAXVzuBzmyRA_5=EEWBnmk99@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Fixup booting with device trees and uImage/elf on
	ppc32
From: Maxim Uvarov <muvarov@gmail.com>
To: Simon Horman <horms@verge.net.au>
Content-Type: multipart/alternative; boundary=0016e64cad1e7907a3048c56887b
Cc: Matthew McClintock <msm@freescale.com>, sebastian@breakpoint.cc,
	kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e64cad1e7907a3048c56887b
Content-Type: text/plain; charset=ISO-8859-1

2010/7/27 Simon Horman <horms@verge.net.au>

> [Cced linuxppc-dev]
>
> On Tue, Jul 20, 2010 at 11:42:57PM -0500, Matthew McClintock wrote:
> > This patch series adds full support for booting with a flat device tree
> > with either uImage or elf file formats. Kexec and Kdump should work, and
> > you should also be able to use ramdisks or reuse your current ramdisk as
> well
> >
> > This patch series was tested on an mpc85xx system with a kernel version
> > 2.6.35-rc3
> >
> > v1: Initial version
> >
> > v2: Added support for fs2dt (file system to device tree)
> >
> > v3: Fix some misc. git problems I had and other code cleanups
>
> Hi Matthew,
>
> I'm a little concerned that these changes are non trivial and haven't had
> much review. But I am prepared to put them into my tree once 2.0.2 is
> released - perhaps that way they will get some test coverage. Does
> that work for you?
>
> Actually  Matthew did that did not work before. Like kdump for booke. But
because kernel patches are not already in it's not urgent to commit it right
now.

> >
> > Matthew McClintock (7):
> >   Restore kexec uImage-ppc to working state
> >   Fix case where phys_addr_t != unsigned long when reading proc entries
> >   Update uImage to support crash kernel and misc fixes
> >   Update Elf-ppc to support crash kernel and misc fixes
> >   Add support for ramdisk on ppc32 for uImage-ppc and Elf-ppc
> >   Add support for reworking flat device tree support
> >   Add documentation/howto for mpc85xx systems
> >
> >  doc/mpc85xx.txt                       |  190 +++++++++++++++++++++
> >  kexec/arch/ppc/Makefile               |    1 +
> >  kexec/arch/ppc/fixup_dtb.c            |  298
> ++++++++++++++++++++++++++++++++-
> >  kexec/arch/ppc/fixup_dtb.h            |    6 +-
> >  kexec/arch/ppc/include/arch/options.h |    3 +
> >  kexec/arch/ppc/kexec-elf-ppc.c        |  186 +++++++++------------
> >  kexec/arch/ppc/kexec-ppc.c            |  262
> +++++++++++++++++------------
> >  kexec/arch/ppc/kexec-ppc.h            |    3 +
> >  kexec/arch/ppc/kexec-uImage-ppc.c     |  136 ++++++++++++---
> >  kexec/arch/ppc/ops.h                  |    1 -
> >  purgatory/arch/ppc/purgatory-ppc.c    |    5 +
> >  11 files changed, 852 insertions(+), 239 deletions(-)
> >  create mode 100644 doc/mpc85xx.txt
> >
> >
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
>



-- 
Best regards,
Maxim Uvarov

--0016e64cad1e7907a3048c56887b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2010/7/27 Simon Horman <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:horms@verge.net.au">horms@verge.net.au</a>&gt;</span=
><br><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; =
border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
[Cced linuxppc-dev]<br>
<div class=3D"im"><br>
On Tue, Jul 20, 2010 at 11:42:57PM -0500, Matthew McClintock wrote:<br>
&gt; This patch series adds full support for booting with a flat device tre=
e<br>
&gt; with either uImage or elf file formats. Kexec and Kdump should work, a=
nd<br>
&gt; you should also be able to use ramdisks or reuse your current ramdisk =
as well<br>
&gt;<br>
&gt; This patch series was tested on an mpc85xx system with a kernel versio=
n<br>
&gt; 2.6.35-rc3<br>
&gt;<br>
&gt; v1: Initial version<br>
&gt;<br>
&gt; v2: Added support for fs2dt (file system to device tree)<br>
&gt;<br>
&gt; v3: Fix some misc. git problems I had and other code cleanups<br>
<br>
</div>Hi Matthew,<br>
<br>
I&#39;m a little concerned that these changes are non trivial and haven&#39=
;t had<br>
much review. But I am prepared to put them into my tree once 2.0.2 is<br>
released - perhaps that way they will get some test coverage. Does<br>
that work for you?<br>
<div class=3D"im"><br></div></blockquote><div>Actually=A0 Matthew did that =
did not work before. Like kdump for booke. But because kernel patches are n=
ot already in it&#39;s not urgent to commit it right now. <br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left:=
 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">
&gt;<br>
&gt; Matthew McClintock (7):<br>
&gt; =A0 Restore kexec uImage-ppc to working state<br>
&gt; =A0 Fix case where phys_addr_t !=3D unsigned long when reading proc en=
tries<br>
&gt; =A0 Update uImage to support crash kernel and misc fixes<br>
&gt; =A0 Update Elf-ppc to support crash kernel and misc fixes<br>
&gt; =A0 Add support for ramdisk on ppc32 for uImage-ppc and Elf-ppc<br>
&gt; =A0 Add support for reworking flat device tree support<br>
&gt; =A0 Add documentation/howto for mpc85xx systems<br>
&gt;<br>
&gt; =A0doc/mpc85xx.txt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A019=
0 +++++++++++++++++++++<br>
&gt; =A0kexec/arch/ppc/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +<br=
>
&gt; =A0kexec/arch/ppc/fixup_dtb.c =A0 =A0 =A0 =A0 =A0 =A0| =A0298 ++++++++=
++++++++++++++++++++++++-<br>
&gt; =A0kexec/arch/ppc/fixup_dtb.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A06 +-<br>
&gt; =A0kexec/arch/ppc/include/arch/options.h | =A0 =A03 +<br>
&gt; =A0kexec/arch/ppc/kexec-elf-ppc.c =A0 =A0 =A0 =A0| =A0186 +++++++++---=
---------<br>
&gt; =A0kexec/arch/ppc/kexec-ppc.c =A0 =A0 =A0 =A0 =A0 =A0| =A0262 ++++++++=
+++++++++------------<br>
&gt; =A0kexec/arch/ppc/kexec-ppc.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A03 +<br>
&gt; =A0kexec/arch/ppc/kexec-uImage-ppc.c =A0 =A0 | =A0136 ++++++++++++---<=
br>
&gt; =A0kexec/arch/ppc/ops.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 =
-<br>
&gt; =A0purgatory/arch/ppc/purgatory-ppc.c =A0 =A0| =A0 =A05 +<br>
&gt; =A011 files changed, 852 insertions(+), 239 deletions(-)<br>
&gt; =A0create mode 100644 doc/mpc85xx.txt<br>
&gt;<br>
&gt;<br>
&gt;<br>
</div>&gt; _______________________________________________<br>
&gt; kexec mailing list<br>
&gt; <a href=3D"mailto:kexec@lists.infradead.org">kexec@lists.infradead.org=
</a><br>
&gt; <a href=3D"http://lists.infradead.org/mailman/listinfo/kexec" target=
=3D"_blank">http://lists.infradead.org/mailman/listinfo/kexec</a><br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>Best regards,<br>Maxim =
Uvarov<br>

--0016e64cad1e7907a3048c56887b--
