Return-Path: <anca.emanuel@gmail.com>
Received: from mail-vb0-f46.google.com (mail-vb0-f46.google.com
 [209.85.212.46])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4A6C02C034A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jan 2013 06:48:12 +1100 (EST)
Received: by mail-vb0-f46.google.com with SMTP id b13so1792222vby.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2013 11:48:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1301111705170.23005@ayla.of.borg>
References: <alpine.DEB.2.00.1301111704550.22961@ayla.of.borg>
 <alpine.DEB.2.00.1301111705170.23005@ayla.of.borg>
Date: Fri, 11 Jan 2013 21:48:08 +0200
Message-ID: <CAJL_dMsXvEw=UvmodFEK0uefJ_kNVn2NRpbOcWMJwdLBP3nB7A@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.8-rc3
From: Anca Emanuel <anca.emanuel@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux/PPC Development <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Development <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Spark mantainer ?

"To make this mail fit in the lkml limit, I deleted
  - 3996 lines about __mcount_loc on sparc64"

On Fri, Jan 11, 2013 at 6:07 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, 11 Jan 2013, Geert Uytterhoeven wrote:
>> JFYI, when comparing v3.8-rc3 to v3.8-rc2[3], the summaries are:
>>   - build errors: +2/-414
>
>   + arch/powerpc/sysdev/mpic.c: error: case label does not reduce to an integer constant:  => 890:9, 898:9, 886:9, 894:9
>   + error: No rule to make target drivers/scsi/aic7xxx/aicasm/*.[chyl]:  => N/A
>
> powerpc-randconfig
>
>> [1] http://kisskb.ellerman.id.au/kisskb/head/5780/ (all 117 configs)
>> [3] http://kisskb.ellerman.id.au/kisskb/head/5767/ (all 117 configs)
>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                                             -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
