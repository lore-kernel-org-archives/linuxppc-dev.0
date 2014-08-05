Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-lb0-x230.google.com (mail-lb0-x230.google.com
 [IPv6:2a00:1450:4010:c04::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DD6091A0148
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 17:26:58 +1000 (EST)
Received: by mail-lb0-f176.google.com with SMTP id u10so387190lbd.21
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Aug 2014 00:26:54 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1407222997-31109-1-git-send-email-geert@linux-m68k.org>
References: <1407222997-31109-1-git-send-email-geert@linux-m68k.org>
Date: Tue, 5 Aug 2014 09:26:54 +0200
Message-ID: <CAMuHMdUekNbigyNeEps6Q_i0jsKVq=rUV-aD0JNRQYg53gYdyQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.16
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 5, 2014 at 9:16 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.16[1]  to v3.16-rc7[3], the summaries are:
>   - build errors: +3/-1

  + error: tpm_ibmvtpm.c: undefined reference to
`.__vio_register_driver':  => .init.text+0x6950)
  + error: tpm_ibmvtpm.c: undefined reference to
`.plpar_hcall_norets':  => .text+0xedc1c), .text+0xedae4),
.text+0xedde0), .text+0xedb9c), .text+0xeda70)
  + error: tpm_ibmvtpm.c: undefined reference to
`.vio_unregister_driver':  => .exit.text+0x1920)

powerpc-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/7732/ (all 119 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/7708/ (all 119 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
