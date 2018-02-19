Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlQT95vrDzDr14
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 01:03:39 +1100 (AEDT)
Received: by mail-qt0-x241.google.com with SMTP id d26so12276922qtk.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 06:03:39 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1519048647-18732-1-git-send-email-geert@linux-m68k.org>
References: <1519048647-18732-1-git-send-email-geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Feb 2018 15:03:36 +0100
Message-ID: <CAMuHMdWs9r4F7FnuHvQGX1L9g91MCepSHroRDhj1tB9E70d5gw@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.16-rc2
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Michael Bringmann <mwb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 19, 2018 at 2:57 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.16-rc2[1] to v4.16-rc1[3], the summaries are:
>   - build errors: +5/-2

  + /home/kisskb/slave/src/arch/arm64/kernel/head.S: Error: junk at
end of line, first unrecognized character is `U':  => 677
  + /home/kisskb/slave/src/arch/arm64/kernel/head.S: Error: missing ')':  => 677
  + /home/kisskb/slave/src/arch/arm64/kernel/head.S: Error: unexpected
characters following instruction at operand 2 -- `movk
x1,:abs_g0_nc:0xff00ffffffUL':  => 677
  + /home/kisskb/slave/src/arch/arm64/kernel/head.S: Error: unexpected
characters following instruction at operand 2 -- `movz
x1,:abs_g1_s:0xff00ffffffUL':  => 677

arm64-allnoconfig
arm64-allmodconfig
arm64-defconfig
(patch available)

  + error: hotplug-cpu.c: undefined reference to
`timed_topology_update':  => .text+0x410), .text+0x138)

ppc64le/pseries_le_defconfig+NO_NUMA

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
