Return-Path: <kda@linux-powerpc.org>
Received: from mail-yh0-f46.google.com (mail-yh0-f46.google.com
 [209.85.213.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 344581A0C83
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 06:16:34 +1100 (AEDT)
Received: by mail-yh0-f46.google.com with SMTP id z6so12368595yhz.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Feb 2015 11:16:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20150215.110729.1985006476906451021.davem@davemloft.net>
References: <1424023605-2416-1-git-send-email-kda@linux-powerpc.org>
 <1424023605-2416-2-git-send-email-kda@linux-powerpc.org>
 <1424024154.2685.1.camel@perches.com>
 <20150215.110729.1985006476906451021.davem@davemloft.net>
Date: Sun, 15 Feb 2015 23:16:31 +0400
Message-ID: <CAOJe8K2V3Wde6dLE3QyBZKK7YSEpzBXZi+5VSCJsr5QiYNOQCg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/6] ppc: Kconfig: Enable BPF JIT on ppc32
From: Denis Kirjanov <kda@linux-powerpc.org>
To: David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8
Cc: joe@perches.com, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2/15/15, David Miller <davem@davemloft.net> wrote:
> From: Joe Perches <joe@perches.com>
> Date: Sun, 15 Feb 2015 10:15:54 -0800
>
>> On Sun, 2015-02-15 at 21:06 +0300, Denis Kirjanov wrote:
>> []
>>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> []
>>> @@ -126,7 +126,7 @@ config PPC
>>>  	select IRQ_FORCED_THREADING
>>>  	select HAVE_RCU_TABLE_FREE if SMP
>>>  	select HAVE_SYSCALL_TRACEPOINTS
>>> -	select HAVE_BPF_JIT if PPC64
>>> +	select HAVE_BPF_JIT
>>
>> trivia:
>>
>> Should this be the last patch of the series?
>
> Yes, that's the way I see it too.
>

Ok, I'll resend the series if the such thing matters.

Thank you.
