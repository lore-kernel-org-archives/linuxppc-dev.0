Return-Path: <bobby.prani@gmail.com>
Received: from mail-vc0-x233.google.com (mail-vc0-x233.google.com
 [IPv6:2607:f8b0:400c:c03::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4AE5F1A0BE4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 00:57:43 +1100 (AEDT)
Received: by mail-vc0-f179.google.com with SMTP id le20so1243891vcb.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Dec 2014 05:57:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20141221205604.5a280c9d@canb.auug.org.au>
References: <1419094041-14536-1-git-send-email-bobby.prani@gmail.com>
 <20141221205604.5a280c9d@canb.auug.org.au>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Sun, 21 Dec 2014 08:57:10 -0500
Message-ID: <CAJhHMCCnS6cEuATp-jScDpAjv7fgMm_v=gu650gE=UNK7GupQA@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Wire up sys_execveat() syscall
To: Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Cc: LKML <linux-kernel@vger.kernel.org>, Fabian Frederick <fabf@skynet.be>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 David Herrmann <dh.herrmann@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Dec 21, 2014 at 4:56 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Pranith,
>
> On Sat, 20 Dec 2014 11:47:18 -0500 Pranith Kumar <bobby.prani@gmail.com> wrote:
>>
>> Wire up sys_execveat(). This passes the selftests for the system call.
>
> Thanks for this, but ...
>
>> diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
>> index ce9577d..778844a 100644
>> --- a/arch/powerpc/include/asm/systbl.h
>> +++ b/arch/powerpc/include/asm/systbl.h
>> @@ -366,3 +366,4 @@ SYSCALL_SPU(seccomp)
>>  SYSCALL_SPU(getrandom)
>>  SYSCALL_SPU(memfd_create)
>>  SYSCALL_SPU(bpf)
>> +SYSCALL_SPU(execveat)
>
> Given that it passes pointers into the kernel and looking at the execve
> system call, I assume that it should be COMPAT_SYS().
>

Yes, you are right. I will send in an updated patch. Thanks!
-- 
Pranith
