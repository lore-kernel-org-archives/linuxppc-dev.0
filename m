Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1D58E2C0119
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2013 19:20:25 +1000 (EST)
Received: by mail-pa0-f41.google.com with SMTP id bj1so9431510pad.14
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2013 02:20:22 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1379412095-7213-1-git-send-email-geert@linux-m68k.org>
References: <1379412095-7213-1-git-send-email-geert@linux-m68k.org>
Date: Thu, 19 Sep 2013 11:20:22 +0200
Message-ID: <CAMuHMdW8y9_=LXQ1PXjFaPyq-nYTPe+FodE5hQh4P3QSdnP_dg@mail.gmail.com>
Subject: Re: Preliminary kexec support for Linux/m68k
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>, kexec@lists.infradead.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 17, 2013 at 12:01 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> This is a preliminary set of patches to add kexec support for m68k.

>   - [PATCH 1/3] m68k: Add preliminary kexec support
>   - [PATCH 2/3] m68k: Add support to export bootinfo in procfs
>   - [PATCH 3/3] [RFC] m68k: Add System RAM to /proc/iomem
>
> Notes:
>   - The bootinfo is now saved and exported to /proc/bootinfo, so kexec-tools
>     can read it and pass it (possibly after modification) to the new kernel.
>     This is similar to /proc/atags on ARM.

>   - I based [PATCH 3/3] on the PowerPC version, but it's no longer needed as we
>     now get this information from the bootinfo.
>     Does anyone think this is nice to have anyway?

It seems kexec/kdump on ppc don't use /proc/iomem anymore, and only rely on
/proc/device-tree these days?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
