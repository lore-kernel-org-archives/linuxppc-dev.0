Return-Path: <kda@linux-powerpc.org>
Received: from mail-yh0-f41.google.com (mail-yh0-f41.google.com
 [209.85.213.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 55DA41A0245
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 08:07:53 +1100 (AEDT)
Received: by yhzz6 with SMTP id z6so1467273yhz.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Feb 2015 13:07:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20150219.155613.1219259214030608341.davem@davemloft.net>
References: <1424156683-2682-1-git-send-email-kda@linux-powerpc.org>
 <20150219.155613.1219259214030608341.davem@davemloft.net>
Date: Fri, 20 Feb 2015 01:07:50 +0400
Message-ID: <CAOJe8K0awkwdYNZr5GdRJFQLCJ0F1GOF730Q3UwT7KBJw0c7Uw@mail.gmail.com>
Subject: Re: bpf: Enable BPF JIT on ppc32
From: Denis Kirjanov <kda@linux-powerpc.org>
To: David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2/19/15, David Miller <davem@davemloft.net> wrote:
> From: Denis Kirjanov <kda@linux-powerpc.org>
> Date: Tue, 17 Feb 2015 10:04:37 +0300
>
>> This patch series enables BPF JIT on ppc32. There are relatevily
>> few chnages in the code to make it work.
>>
>> All test_bpf tests passed both on 7447a and P2041-based machines.
>>
>> Changelog:
>> v1 - > v2: Reordered Kconfig patch in the series
>
> Who plans to take this series?  A PowerPC maintainer?
>
> If not, should I take it?
>

I think that it should go through your tree...
