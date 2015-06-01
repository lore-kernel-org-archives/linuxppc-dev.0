Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ob0-x230.google.com (mail-ob0-x230.google.com
 [IPv6:2607:f8b0:4003:c01::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D8E481A016E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 20:13:17 +1000 (AEST)
Received: by obbea2 with SMTP id ea2so99514558obb.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2015 03:13:14 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1433153392-18037-1-git-send-email-geert@linux-m68k.org>
References: <1433153392-18037-1-git-send-email-geert@linux-m68k.org>
Date: Mon, 1 Jun 2015 12:13:14 +0200
Message-ID: <CAMuHMdW6MAj6bOMY_RRt9=OF2iM2Gy4bCXWCEWK7hM5ia1Rtvg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.1-rc6
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Prabhakar Lad <prabhakar.csengg@gmail.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 1, 2015 at 12:09 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.1-rc6[1] to v4.1-rc5[3], the summaries are:
>   - build errors: +8/-52

  + /home/kisskb/slave/src/drivers/media/i2c/ov2659.c: error: 'struct
v4l2_subdev_fh' has no member named 'pad':  => 1264:38
  + /home/kisskb/slave/src/drivers/media/i2c/ov2659.c: error: implicit
declaration of function 'v4l2_subdev_get_try_format'
[-Werror=implicit-function-declaration]:  => 1054:3

i386-randconfig

  + error: aes.c: undefined reference to `.enable_kernel_altivec':  =>
.text+0x48e894), .text+0x48e6e0), .text+0x48e960)
  + error: aes_cbc.c: undefined reference to `.enable_kernel_altivec':
 => .text+0x48ea98), .text+0x48ebf4)

powerpc-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/8943/ (254 out of 257 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/8914/ (254 out of 257 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
