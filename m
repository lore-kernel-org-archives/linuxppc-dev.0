Return-Path: <kda@linux-powerpc.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C3B391A054F
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Nov 2014 04:49:31 +1100 (AEDT)
Received: from mail-oi0-f44.google.com (mail-oi0-f44.google.com
 [209.85.218.44])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1270F14009E
 for <linuxppc-dev@ozlabs.org>; Sun,  2 Nov 2014 04:49:30 +1100 (AEDT)
Received: by mail-oi0-f44.google.com with SMTP id h136so7069038oig.17
 for <linuxppc-dev@ozlabs.org>; Sat, 01 Nov 2014 10:49:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20141101.133957.1365371956675094081.davem@davemloft.net>
References: <CAADnVQKvfay7zC-kNGXz7uAjVrhqL80xQ=zvmAsSz4pNhD=9NQ@mail.gmail.com>
 <CAHj3AVkpouHa1y0jt9c5dyYvnd6dctociTMW1ORdxaKdsFEbhQ@mail.gmail.com>
 <CAOJe8K31iB9+7c1BnS=6DdriU08WUisM7sYgj8nOBo4Fg=XUBg@mail.gmail.com>
 <20141101.133957.1365371956675094081.davem@davemloft.net>
Date: Sat, 1 Nov 2014 21:49:27 +0400
Message-ID: <CAOJe8K2FzuPTZ5pch8_UK7X==+=k8RKLnfz0mZb2hca19aU4pg@mail.gmail.com>
Subject: Re: [PATCH v2] PPC: bpf_jit_comp: add SKF_AD_PKTTYPE instruction
From: Denis Kirjanov <kda@linux-powerpc.org>
To: David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, matt@ozlabs.org,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David, you need a feedback from other guys to apply this patch, right?

Alexei wanted some output before/after the patch.
Michael Ellerman wanted the explanation what a BPF_ANC | SKF_AD_PKTTYPE means.
So I'm waiting  the ack/nack from them...

On 11/1/14, David Miller <davem@davemloft.net> wrote:
> From: Denis Kirjanov <kda@linux-powerpc.org>
> Date: Sat, 1 Nov 2014 20:19:09 +0400
>
>> ping
>
> What specifically are you waiting for?
>
