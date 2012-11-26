Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
 [209.85.220.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 54F012C0081
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2012 07:56:10 +1100 (EST)
Received: by mail-vc0-f179.google.com with SMTP id p1so6971591vcq.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2012 12:56:07 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1353963243-21887-1-git-send-email-geert@linux-m68k.org>
References: <1353963243-21887-1-git-send-email-geert@linux-m68k.org>
Date: Mon, 26 Nov 2012 21:56:06 +0100
Message-ID: <CAMuHMdWjpQ1+=MoxUCLvv4dMkjVV3Y2XoiwFWbHMTkZeeOQheQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.7-rc7
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 26, 2012 at 9:54 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.7-rc7 to v3.7-rc6[3], the summaries are:
>   - build errors: +4/-8

  + error: "__sync_fetch_and_and_4"
[drivers/staging/line6/line6usb.ko] undefined!:  => N/A
  + error: "__sync_fetch_and_or_4" [drivers/staging/line6/line6usb.ko]
undefined!:  => N/A

sh4/sh-randconfig

  + error: "smp_send_reschedule" [arch/powerpc/kvm/kvm.ko] undefined!:  => N/A

powerpc/powerpc-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/5646/ (all 117 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/5628/ (all 117 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
