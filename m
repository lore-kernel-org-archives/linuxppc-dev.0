Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-pb0-x22d.google.com (mail-pb0-x22d.google.com
 [IPv6:2607:f8b0:400e:c01::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CBA172C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 18:56:59 +1000 (EST)
Received: by mail-pb0-f45.google.com with SMTP id mc17so5754851pbc.32
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 01:56:57 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1380099255-25559-1-git-send-email-geert@linux-m68k.org>
References: <1380099255-25559-1-git-send-email-geert@linux-m68k.org>
Date: Wed, 25 Sep 2013 10:56:57 +0200
Message-ID: <CAMuHMdUBaFWH6rmUMpr=fJ2J_bXjnK2CqdZaCWxqqQFXutuEGQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.12-rc2
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

On Wed, Sep 25, 2013 at 10:54 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.12-rc2 to v3.12-rc1[3], the summaries are:
>   - build errors: +15/-11

  + error: arch/powerpc/kernel/entry_32.S: undefined reference to
`uprobe_post_sstep_notifier':  => .text+0x10570)
  + error: arch/powerpc/kernel/entry_32.S: undefined reference to
`uprobe_pre_sstep_notifier':  => .text+0x10564)
  + error: fork.c: undefined reference to `uprobe_clear_state':  => .text+0xff4)
  + error: fork.c: undefined reference to `uprobe_copy_process':  =>
.text+0x1974)
  + error: fork.c: undefined reference to `uprobe_dup_mmap':  => .text+0x5d0)
  + error: fork.c: undefined reference to `uprobe_end_dup_mmap':  =>
.text+0x890)
  + error: fork.c: undefined reference to `uprobe_start_dup_mmap':  =>
.text+0x5b4)
  + error: memory.c: undefined reference to `uprobe_munmap':  => .text+0x27c78)
  + error: trace_uprobe.c: undefined reference to `uprobe_register':
=> .text+0x9aaa0)
  + error: trace_uprobe.c: undefined reference to `uprobe_unregister':
 => .text+0x9a9fc)

powerpc-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/6701/ (all 120 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/6676/ (all 120 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
