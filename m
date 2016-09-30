Return-Path: <kda@linux-powerpc.org>
Received: from mail-yb0-x243.google.com (mail-yb0-x243.google.com
 [IPv6:2607:f8b0:4002:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3slxfK3cLYzDvKw
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Oct 2016 02:26:48 +1000 (AEST)
Received: by mail-yb0-x243.google.com with SMTP id z8so1564050ybh.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 09:26:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1475181427.git.christophe.leroy@c-s.fr>
References: <cover.1475181427.git.christophe.leroy@c-s.fr>
From: Denis Kirjanov <kda@linux-powerpc.org>
Date: Fri, 30 Sep 2016 19:26:46 +0300
Message-ID: <CAOJe8K2bYSGe5ciY75eSbthkXNtQwJ2LBdgWcyqqo_jwhmoUsg@mail.gmail.com>
Subject: Re: [PATCH 0/2] powerpc: stack protector (-fstack-protector) support
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 Nicolas Pitre <nicolas.pitre@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/alternative; boundary=001a114888507f2de4053dbc0f67
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a114888507f2de4053dbc0f67
Content-Type: text/plain; charset=UTF-8

On Friday, September 30, 2016, Christophe Leroy <christophe.leroy@c-s.fr>
wrote:

> Add HAVE_CC_STACKPROTECTOR to powerpc. This is copied from ARM.
>
> Not tested on PPC64, compile ok with ppc64_


Hi Christophe,

are you going to test it on ppc64? If not, I can take it


>
> Christophe Leroy (2):
>   powerpc: initial stack protector (-fstack-protector) support
>   powerpc/32: stack protector: change the canary value per task
>
>  arch/powerpc/Kconfig                      |  1 +
>  arch/powerpc/include/asm/stackprotector.h | 38
> +++++++++++++++++++++++++++++++
>  arch/powerpc/kernel/Makefile              |  5 ++++
>  arch/powerpc/kernel/asm-offsets.c         |  3 +++
>  arch/powerpc/kernel/entry_32.S            |  6 ++++-
>  arch/powerpc/kernel/process.c             |  6 +++++
>  6 files changed, 58 insertions(+), 1 deletion(-)
>  create mode 100644 arch/powerpc/include/asm/stackprotector.h
>
> --
> 2.1.0
>
>

--001a114888507f2de4053dbc0f67
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, September 30, 2016, Christophe Leroy &lt;<a href=3D"mail=
to:christophe.leroy@c-s.fr">christophe.leroy@c-s.fr</a>&gt; wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">Add HAVE_CC_STACKPROTECTOR to powerpc. This is co=
pied from ARM.<br>
<br>
Not tested on PPC64, compile ok with ppc64_</blockquote><div><br></div><div=
>Hi Christophe,=C2=A0</div><div><br></div><div>are you going to test it on =
ppc64? If not, I can take it</div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">
<br>
Christophe Leroy (2):<br>
=C2=A0 powerpc: initial stack protector (-fstack-protector) support<br>
=C2=A0 powerpc/32: stack protector: change the canary value per task<br>
<br>
=C2=A0arch/powerpc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0arch/powerpc/include/asm/<wbr>stackprotector.h | 38 +++++++++++++++++=
+++++++++++++<wbr>+<br>
=C2=A0arch/powerpc/kernel/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 5 ++++<br>
=C2=A0arch/powerpc/kernel/asm-<wbr>offsets.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 3 +++<br>
=C2=A0arch/powerpc/kernel/entry_32.S=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 6 ++++-<br>
=C2=A0arch/powerpc/kernel/process.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 6 +++++<br>
=C2=A06 files changed, 58 insertions(+), 1 deletion(-)<br>
=C2=A0create mode 100644 arch/powerpc/include/asm/<wbr>stackprotector.h<br>
<br>
--<br>
2.1.0<br>
<br>
</blockquote>

--001a114888507f2de4053dbc0f67--
