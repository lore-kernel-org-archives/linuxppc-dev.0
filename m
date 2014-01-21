Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-pd0-x229.google.com (mail-pd0-x229.google.com
 [IPv6:2607:f8b0:400e:c02::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 54A082C009C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 19:41:08 +1100 (EST)
Received: by mail-pd0-f169.google.com with SMTP id v10so7931117pde.28
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 00:41:05 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1390291850-17849-1-git-send-email-geert@linux-m68k.org>
References: <1390291850-17849-1-git-send-email-geert@linux-m68k.org>
Date: Tue, 21 Jan 2014 09:41:05 +0100
Message-ID: <CAMuHMdVBD7Gn_0zNBD+oVq11=UrCrB-Aocm4EmGRgHdRqF+XoA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.13
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux-sh list <linux-sh@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 21, 2014 at 9:10 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.13[1]  to v3.13-rc8[3], the summaries are:
>   - build errors: +22/-3

  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: (near initialization for 'dmac_resource.end'):  => 87:2
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: (near initialization for 'dmac_resource.start'):  => 86:2
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: (near initialization for 'epbr_resources[0].end'):  => 69:3
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: (near initialization for 'epbr_resources[0].start'):  => 68:3
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: (near initialization for 'epbr_resources[1].end'):  => 74:3
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: (near initialization for 'epbr_resources[1].start'):  => 73:3
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: (near initialization for 'femi_resources[0].end'):  => 50:3
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: (near initialization for 'femi_resources[0].start'):  => 49:3
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: (near initialization for 'femi_resources[1].end'):  => 55:3
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: (near initialization for 'femi_resources[1].start'):  => 54:3
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: (near initialization for 'pbr_resources[0].end'):  => 100:3
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: (near initialization for 'pbr_resources[0].start'):  => 99:3
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: (near initialization for 'pbr_resources[1].end'):  => 105:3
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: (near initialization for 'pbr_resources[1].start'):  => 104:3
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: braced-group within expression allowed only inside a function:
=> 30:12, 73:12, 31:10, 99:12, 68:12, 36:10, 86:11, 54:12, 74:10,
55:10, 104:12, 49:12, 69:10, 87:9, 105:10, 35:12, 50:10, 100:10
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: initializer element is not constant:  => 74:3, 86:2, 55:3,
105:3, 73:3, 68:3, 100:3, 104:3, 99:3, 87:2, 50:3, 69:3, 49:3, 54:3
  + /scratch/kisskb/src/arch/sh/mm/cache-sh4.c: error:
'cached_to_uncached' undeclared (first use in this function):  =>
99:17
  + /scratch/kisskb/src/arch/sh/mm/cache-sh4.c: error: implicit
declaration of function 'cpu_context'
[-Werror=implicit-function-declaration]:  => 192:2
  + /scratch/kisskb/src/kernel/bounds.c: error: -mcall-aixdesc must be
big endian:  => 1:0

sh-randconfig

  + /scratch/kisskb/src/scripts/mod/devicetable-offsets.c: error:
-mcall-aixdesc must be big endian:  => 1:0
  + /scratch/kisskb/src/scripts/mod/empty.c: error: -mcall-aixdesc
must be big endian:  => 1:0
  + <stdin>: error: -mcall-aixdesc must be big endian:  => 1:0

powerpc-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/7082/ (119 out of 120 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/7056/ (119 out of 120 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
