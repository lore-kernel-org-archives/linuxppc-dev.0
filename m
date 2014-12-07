Return-Path: <rickard.strandqvist@spectrumdigital.se>
Received: from mail-la0-f48.google.com (mail-la0-f48.google.com
 [209.85.215.48])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C330A1A05DA
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 10:11:24 +1100 (AEDT)
Received: by mail-la0-f48.google.com with SMTP id gf13so3061869lab.21
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Dec 2014 15:11:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5484D240.30506@nod.at>
References: <1417990021-18696-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <5484D240.30506@nod.at>
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Mon, 8 Dec 2014 00:11:00 +0100
Message-ID: <CAFo99gYvkzCTi6FZXfPOCqafNYn6y4H4hx62KqJjex60KV70_A@mail.gmail.com>
Subject: Re: [PATCH] arch: powerpc: kernel: signal_32.c: Remove unused function
To: Richard Weinberger <richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Cc: Michael Neuling <mikey@neuling.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi

Ok, sorry :-(

But I really do not. I've hacked together a script that will scan all
the code for the function, and test builds with some different config
options turned on.


Kind regards
Rickard Strandqvist


2014-12-07 23:18 GMT+01:00 Richard Weinberger <richard@nod.at>:
> Am 07.12.2014 um 23:07 schrieb Rickard Strandqvist:
>> Remove the function sys_debug_setcontext() that is not used anywhere.
>>
>> This was partially found by using a static code analysis program called cppcheck.
>
> Please don't blindly trust code analysis tools.
> The function you're removing *is* in use.
>
>   LD      init/built-in.o
> arch/powerpc/kernel/built-in.o: In function `sys_call_table':
> (.rodata+0x744): undefined reference to `sys_debug_setcontext'
> make: *** [vmlinux] Error 1
>
> Thanks,
> //richard
