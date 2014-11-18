Return-Path: <vvijayan@mvista.com>
Received: from mail-ie0-f177.google.com (mail-ie0-f177.google.com
 [209.85.223.177])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A1FAB1A08F5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 18:10:41 +1100 (AEDT)
Received: by mail-ie0-f177.google.com with SMTP id tr6so4502993ieb.22
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 23:10:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1416207214.2826.3.camel@concordia>
References: <1415956325-10124-1-git-send-email-vvijayan@mvista.com>
 <1416207214.2826.3.camel@concordia>
From: Vineeth Vijayan <vvijayan@mvista.com>
Date: Tue, 18 Nov 2014 12:40:19 +0530
Message-ID: <CAOpNGctfy1uE4zLaNH5D1r_Hsj60FE+RkKR7UawvUSecbdcVUw@mail.gmail.com>
Subject: Re: [PATCH] [powerpc] Fix Text randomization
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: multipart/alternative; boundary=047d7bdc9daee4d8b405081ccadc
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--047d7bdc9daee4d8b405081ccadc
Content-Type: text/plain; charset=UTF-8

On Mon, Nov 17, 2014 at 12:23 PM, Michael Ellerman <mpe@ellerman.id.au>
wrote:

> On Fri, 2014-11-14 at 14:42 +0530, Vineeth Vijayan wrote:
> > Now there is no way to disable TEXT randomization on a PPC32/PPC64
> > machine. Text randomization happens even in the case of "echo 0 >
> > /proc/sys/kernel/randomize_va_space"
> >
> > This happens due to the incorrect definition of ELF_ET_DYN_BASE
> > at arch/powerpc/include/asm/elf.h
> >
> > The function randomize_et_dyn is redundant and is removed.
>
> The patch looks OK, but for the change log I was thinking something more
> like
> this:
>
>
> powerpc: Use generic PIE randomization
>
> Do you want me to send a new patch with updated change log as mentioned ?

--047d7bdc9daee4d8b405081ccadc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Mon, Nov 17, 2014 at 12:23 PM, Michael Ellerman <span dir=3D"ltr">&l=
t;<a href=3D"mailto:mpe@ellerman.id.au" target=3D"_blank">mpe@ellerman.id.a=
u</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">=
On Fri, 2014-11-14 at 14:42 +0530, Vineeth Vijayan wrote:<br>
&gt; Now there is no way to disable TEXT randomization on a PPC32/PPC64<br>
&gt; machine. Text randomization happens even in the case of &quot;echo 0 &=
gt;<br>
&gt; /proc/sys/kernel/randomize_va_space&quot;<br>
&gt;<br>
&gt; This happens due to the incorrect definition of ELF_ET_DYN_BASE<br>
&gt; at arch/powerpc/include/asm/elf.h<br>
&gt;<br>
&gt; The function randomize_et_dyn is redundant and is removed.<br>
<br>
</span>The patch looks OK, but for the change log I was thinking something =
more like<br>
this:<br>
<br>
<br>
powerpc: Use generic PIE randomization<br>
<br></blockquote><div>Do you want me to send a new patch with updated chang=
e log as mentioned ?<br></div></div></div></div>

--047d7bdc9daee4d8b405081ccadc--
