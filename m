Return-Path: <vvijayan@mvista.com>
Received: from mail-ig0-f174.google.com (mail-ig0-f174.google.com
 [209.85.213.174])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A3FBD1A088C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 18:20:39 +1100 (AEDT)
Received: by mail-ig0-f174.google.com with SMTP id hn15so537273igb.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 23:20:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1416207214.2826.3.camel@concordia>
References: <1415956325-10124-1-git-send-email-vvijayan@mvista.com>
 <1416207214.2826.3.camel@concordia>
From: Vineeth Vijayan <vvijayan@mvista.com>
Date: Tue, 18 Nov 2014 12:50:17 +0530
Message-ID: <CAOpNGcuL-0SDSwDbExLWqWxwp=0zRtRnx_MUnNEb9ywSFrhh8A@mail.gmail.com>
Subject: Re: [PATCH] [powerpc] Fix Text randomization
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 17, 2014 at 12:23 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Fri, 2014-11-14 at 14:42 +0530, Vineeth Vijayan wrote:
>> Now there is no way to disable TEXT randomization on a PPC32/PPC64
>> machine. Text randomization happens even in the case of "echo 0 >
>> /proc/sys/kernel/randomize_va_space"
>>
>> This happens due to the incorrect definition of ELF_ET_DYN_BASE
>> at arch/powerpc/include/asm/elf.h
>>
>> The function randomize_et_dyn is redundant and is removed.
>
> The patch looks OK, but for the change log I was thinking something more like
> this:
>
>
> powerpc: Use generic PIE randomization
>
Ok. Thats better.
Do you want me to send a new patch with updated change log as mentioned ?
