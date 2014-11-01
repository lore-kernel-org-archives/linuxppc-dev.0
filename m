Return-Path: <kda@linux-powerpc.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 150891A0551
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Nov 2014 03:19:14 +1100 (AEDT)
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2397714010C
 for <linuxppc-dev@ozlabs.org>; Sun,  2 Nov 2014 03:19:11 +1100 (AEDT)
Received: by mail-ob0-f179.google.com with SMTP id m8so7385975obr.10
 for <linuxppc-dev@ozlabs.org>; Sat, 01 Nov 2014 09:19:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHj3AVkpouHa1y0jt9c5dyYvnd6dctociTMW1ORdxaKdsFEbhQ@mail.gmail.com>
References: <1414649535-3956-1-git-send-email-kda@linux-powerpc.org>
 <CAADnVQKvfay7zC-kNGXz7uAjVrhqL80xQ=zvmAsSz4pNhD=9NQ@mail.gmail.com>
 <CAHj3AVkpouHa1y0jt9c5dyYvnd6dctociTMW1ORdxaKdsFEbhQ@mail.gmail.com>
Date: Sat, 1 Nov 2014 20:19:09 +0400
Message-ID: <CAOJe8K31iB9+7c1BnS=6DdriU08WUisM7sYgj8nOBo4Fg=XUBg@mail.gmail.com>
Subject: Re: [PATCH v2] PPC: bpf_jit_comp: add SKF_AD_PKTTYPE instruction
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Denis Kirjanov <kirjanov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Matt Evans <matt@ozlabs.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ping

On 10/31/14, Denis Kirjanov <kirjanov@gmail.com> wrote:
> On 10/30/14, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>> On Wed, Oct 29, 2014 at 11:12 PM, Denis Kirjanov <kda@linux-powerpc.org>
>> wrote:
>>> Add BPF extension SKF_AD_PKTTYPE to ppc JIT to load
>>> skb->pkt_type field.
>>>
>>> Before:
>>> [   88.262622] test_bpf: #11 LD_IND_NET 86 97 99 PASS
>>> [   88.265740] test_bpf: #12 LD_PKTTYPE 109 107 PASS
>>>
>>> After:
>>> [   80.605964] test_bpf: #11 LD_IND_NET 44 40 39 PASS
>>> [   80.607370] test_bpf: #12 LD_PKTTYPE 9 9 PASS
>>
>> if you'd only quoted #12, it would all make sense ;)
>> but #11 test is not using PKTTYPE. So your patch shouldn't
>> make a difference. Are these numbers with JIT on and off?
>
> Right.
>
>> --
>> To unsubscribe from this list: send the line "unsubscribe netdev" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
> --
> Regards,
> Denis
>
