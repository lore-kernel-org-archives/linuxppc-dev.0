Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BFA5AB6EE9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 06:06:32 +1000 (EST)
Received: by werh12 with SMTP id h12so208168wer.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2012 13:06:28 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1340740795-19603-1-git-send-email-geert@linux-m68k.org>
References: <1340740795-19603-1-git-send-email-geert@linux-m68k.org>
Date: Tue, 26 Jun 2012 22:06:27 +0200
Message-ID: <CAMuHMdXY1DFNV+jTiJkT99TbX7ZL5eEiKcG0iqZkUa8T7YZG4g@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.5-rc4
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Cc: the arch/x86 maintainers <x86@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Linux-sh list <linux-sh@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 26, 2012 at 9:59 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.5-rc4 to v3.5-rc3[3], the summaries are:
> =C2=A0- build errors: +11/-219

11 regressions:
  + arch/sh/include/asm/fixmap.h: error: implicit declaration of
function 'BUG_ON' [-Werror=3Dimplicit-function-declaration]:  =3D> 133:2
  + arch/sh/include/asm/thread_info.h: error: implicit declaration of
function 'WARN_ON' [-Werror=3Dimplicit-function-declaration]:  =3D> 172:2
  + include/linux/huge_mm.h: error: implicit declaration of function
'BUG' [-Werror=3Dimplicit-function-declaration]:  =3D> 185:2

shmin_defconfig, se7712_defconfig, se7721_defconfig, sh-allnoconfig

  + arch/x86/include/asm/paravirt.h: error: implicit declaration of
function 'BUG_ON' [-Werror=3Dimplicit-function-declaration]:  =3D> 25:2
  + arch/x86/include/asm/processor.h: error: implicit declaration of
function 'WARN_ON_ONCE' [-Werror=3Dimplicit-function-declaration]:  =3D>
936:2
  + arch/x86/include/asm/thread_info.h: error: implicit declaration of
function 'WARN_ON' [-Werror=3Dimplicit-function-declaration]:  =3D> 251:2
  + include/linux/slub_def.h: error: implicit declaration of function
'BUG' [-Werror=3Dimplicit-function-declaration]:  =3D> 192:2

i386-randconfig

  + error: of_platform.c: undefined reference to
`.pcibios_claim_one_bus':  =3D> .devinit.text+0x160)

powerpc-randconfig

  + include/asm-generic/pgtable.h: error: implicit declaration of
function 'BUG' [-Werror=3Dimplicit-function-declaration]:  =3D> 56:2
  + include/asm-generic/pgtable.h: error: implicit declaration of
function 'BUG':  =3D> 56
  + include/linux/thread_info.h: error: implicit declaration of
function 'WARN_ON':  =3D> 129

avr32-allnoconfig

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
