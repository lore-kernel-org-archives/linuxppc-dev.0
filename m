Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-x235.google.com (mail-yk0-x235.google.com
 [IPv6:2607:f8b0:4002:c07::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7009E1A006B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 20:28:25 +1100 (AEDT)
Received: by ykfs79 with SMTP id s79so231919621ykf.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 01:28:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1448249392.18775.12.camel@ellerman.id.au>
References: <1447913093-28342-1-git-send-email-rashmicy@gmail.com>
 <CAOJe8K0yHTdymRbEo=itvK-AYiNzQLLspNgTyyzADkzpPxpzHw@mail.gmail.com>
 <1448249392.18775.12.camel@ellerman.id.au>
Date: Mon, 23 Nov 2015 12:28:22 +0300
Message-ID: <CAOJe8K2PyaBX6Rx+Md2TsGvbA-T-EupowUeViq-w7NUvp=3BVw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Standardise on NR_syscalls rather than
 __NR_syscalls.
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/23/15, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Thu, 2015-11-19 at 12:15 +0300, Denis Kirjanov wrote:
>
>> On 11/19/15, Rashmica Gupta <rashmicy@gmail.com> wrote:
>
>> > Most architectures use NR_syscalls as the #define for the number of
>> > syscalls.
>> >
>> > We use __NR_syscalls, and then define NR_syscalls as __NR_syscalls.
>> >
>> > __NR_syscalls is not used outside arch code, whereas NR_syscalls is. So
>> > as
>> > NR_syscalls must be defined and __NR_syscalls does not, replace
>> > __NR_syscalls with NR_syscalls.
>>
>> Hi,
>>
>> But what's wrong with the current code? Why do we need such change?
>
> The change log explains it fairly well I think. Which part is not clear?

Ok, first I wasn't aware that NR_syscalls has external users such as
tracing. Agreed, it's better to have only one definition in this case.

>
> cheers
>
>
