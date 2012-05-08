Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com
 [209.85.213.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B8DE4B6FA9
 for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2012 05:22:44 +1000 (EST)
Received: by yhfq11 with SMTP id q11so4027193yhf.15
 for <linuxppc-dev@ozlabs.org>; Tue, 08 May 2012 12:22:42 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1336504803-1951-1-git-send-email-geert@linux-m68k.org>
References: <1336504803-1951-1-git-send-email-geert@linux-m68k.org>
Date: Tue, 8 May 2012 21:22:41 +0200
Message-ID: <CAMuHMdWQFc-5bqnU97+ej81TzUieZ8bt3y6ueXOiX7QX2J_GNw@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.4-rc6
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 8, 2012 at 9:20 PM, Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
> JFYI, when comparing v3.4-rc6 to v3.4-rc5[3], the summaries are:
> =C2=A0- build errors: +2/-1

2 regressions:
  + arch/powerpc/sysdev/mpic.c: error: case label does not reduce to
an integer constant:  =3D> 890:9, 898:9, 886:9, 894:9
  + error: "set_personality_ia32" [arch/x86/ia32/ia32_aout.ko]
undefined!:  =3D> N/A

The former is from powerpc-randconfig, the latter has been fixed in
the mean time.

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
