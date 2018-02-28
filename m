Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-qt0-x232.google.com (mail-qt0-x232.google.com
 [IPv6:2607:f8b0:400d:c0d::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrtdR2KBFzF1YB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 22:29:45 +1100 (AEDT)
Received: by mail-qt0-x232.google.com with SMTP id r16so2472016qtm.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 03:29:45 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1519817278-30770-1-git-send-email-geert@linux-m68k.org>
References: <1519817278-30770-1-git-send-email-geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 Feb 2018 12:29:41 +0100
Message-ID: <CAMuHMdVEFXL6hXhBNya-9LjORrZnyJJPzoBNMrufAdPEBVhLtA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.16-rc3
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 28, 2018 at 12:27 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.16-rc3[1] to v4.16-rc2[3], the summaries are:
>   - build errors: +1/-16

  + /home/kisskb/slave/src/arch/powerpc/kvm/powerpc.c: error: label
'out' defined but not used [-Werror=unused-label]:  => 1611:1

ppc64_defconfig+NO_ALTIVEC

> [1] http://kisskb.ellerman.id.au/kisskb/head/4a3928c6f8a53fa1aed28ccba227742486e8ddcb/ (268 out of 274 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/91ab883eb21325ad80f3473633f794c78ac87f51/ (all 274 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
