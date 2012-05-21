Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com
 [209.85.213.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 064F5B6F77
 for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2012 06:56:50 +1000 (EST)
Received: by yhfq11 with SMTP id q11so4924290yhf.15
 for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2012 13:56:48 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1337629862-23393-1-git-send-email-geert@linux-m68k.org>
References: <1337629862-23393-1-git-send-email-geert@linux-m68k.org>
Date: Mon, 21 May 2012 22:56:47 +0200
Message-ID: <CAMuHMdV8PFRT+APVkSPkgCHxSx806h4rpCJBCHb9NQw=JQLuEg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.4
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Cc: David Howells <dhowells@redhat.com>, Linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 21, 2012 at 9:51 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.4 to v3.4-rc7[3], the summaries are:
> =C2=A0- build errors: +5/-14

  + error: via-pmu-event.c: undefined reference to
`.input_allocate_device':  =3D> .init.text+0x8aa4)
  + error: via-pmu-event.c: undefined reference to
`.input_free_device':  =3D> .init.text+0x8b68)
  + error: via-pmu-event.c: undefined reference to
`.input_register_device':  =3D> .init.text+0x8b54)

powerpc-randconfig

  + kernel/fork.c: error: implicit declaration of function
'alloc_task_struct_node' [-Werror=3Dimplicit-function-declaration]:  =3D>
266:2
  + kernel/fork.c: error: implicit declaration of function
'free_task_struct' [-Werror=3Dimplicit-function-declaration]:  =3D> 174:2

frv-defconfig (ouch)

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
