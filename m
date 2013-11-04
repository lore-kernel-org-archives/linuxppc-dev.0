Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 42EC82C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Nov 2013 18:59:24 +1100 (EST)
Received: by mail-pa0-f52.google.com with SMTP id bj1so6638663pad.11
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 Nov 2013 23:59:22 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20131103210748.E74FAE06C0@canberra.localdomain>
References: <20131103210748.E74FAE06C0@canberra.localdomain>
Date: Mon, 4 Nov 2013 08:59:21 +0100
Message-ID: <CAMuHMdUOUf7shC9A+enCt8qQygG=Qw_soeNJnTWQKr90o2gZhA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] powerpc/embedded6xx: Add support for
 Motorola/Emerson MVME5100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Stephen Chivers <schivers@csc.com>
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

On Sun, Nov 3, 2013 at 10:07 PM, Stephen Chivers <schivers@csc.com> wrote:
> +++ b/arch/powerpc/boot/dts/mvme5100.dts
> @@ -0,0 +1,185 @@
> +/*
> + * Device Tree Souce for Motorola/Emerson MVME5100.

Source

(unless this expresses your personal appreciation for device trees ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
