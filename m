Return-Path: <kernelfans@gmail.com>
Received: from mail-it0-x22b.google.com (mail-it0-x22b.google.com
 [IPv6:2607:f8b0:4001:c0b::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKt7m6SCbzDvj2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 20:32:36 +1100 (AEDT)
Received: by mail-it0-x22b.google.com with SMTP id l8so3725028iti.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 01:32:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87vavlgmq4.fsf@concordia.ellerman.id.au>
References: <CAFgQCTsUmYYSwNEJp=YD_FxVvGsW3G_69PdZxuGcF2P6JS-0vQ@mail.gmail.com>
 <87vavlgmq4.fsf@concordia.ellerman.id.au>
From: Liu ping fan <kernelfans@gmail.com>
Date: Fri, 18 Nov 2016 17:32:34 +0800
Message-ID: <CAFgQCTvmQJ_Gh6R9YJf4EHsJRN5ceNNbhq2twKLdEFiGKTnYrA@mail.gmail.com>
Subject: Re: fadump: a question about "ibm,configure-kernel-dump"
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thank you very much. I am more clear about it now.

On Fri, Nov 18, 2016 at 5:29 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Liu ping fan <kernelfans@gmail.com> writes:
>
>> I have an ibm-p8-garrison machine. But I can not find a node
>> "ibm,configure-kernel-dump" under /proc/device-tree.  Does garrison
>> machine support fadump? And normally, which component in open-power
>> presents the "ibm,configure-kernel-dump" ?  I had though it was in
>> skiboot gitree or  garrison-xml gitree, but found nothing.
>
> fadump only exists for guests running under PowerVM (LPARs). It sounds
> like you're running bare metal (because you mention skiboot).
>
> If you're talking about guests on top of KVM then it *could* be
> implemented, but AFAIK Qemu/KVM do not implement it.
>
> cheers
