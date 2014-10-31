Return-Path: <kirjanov@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 062351A00E5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 17:09:47 +1100 (AEDT)
MIME-Version: 1.0
In-Reply-To: <CAADnVQKvfay7zC-kNGXz7uAjVrhqL80xQ=zvmAsSz4pNhD=9NQ@mail.gmail.com>
References: <1414649535-3956-1-git-send-email-kda@linux-powerpc.org>
 <CAADnVQKvfay7zC-kNGXz7uAjVrhqL80xQ=zvmAsSz4pNhD=9NQ@mail.gmail.com>
Date: Fri, 31 Oct 2014 10:09:43 +0400
Message-ID: <CAHj3AVkpouHa1y0jt9c5dyYvnd6dctociTMW1ORdxaKdsFEbhQ@mail.gmail.com>
Subject: Re: [PATCH v2] PPC: bpf_jit_comp: add SKF_AD_PKTTYPE instruction
From: Denis Kirjanov <kirjanov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Denis Kirjanov <kda@linux-powerpc.org>, Matt Evans <matt@ozlabs.org>,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/30/14, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> On Wed, Oct 29, 2014 at 11:12 PM, Denis Kirjanov <kda@linux-powerpc.org>
> wrote:
>> Add BPF extension SKF_AD_PKTTYPE to ppc JIT to load
>> skb->pkt_type field.
>>
>> Before:
>> [   88.262622] test_bpf: #11 LD_IND_NET 86 97 99 PASS
>> [   88.265740] test_bpf: #12 LD_PKTTYPE 109 107 PASS
>>
>> After:
>> [   80.605964] test_bpf: #11 LD_IND_NET 44 40 39 PASS
>> [   80.607370] test_bpf: #12 LD_PKTTYPE 9 9 PASS
>
> if you'd only quoted #12, it would all make sense ;)
> but #11 test is not using PKTTYPE. So your patch shouldn't
> make a difference. Are these numbers with JIT on and off?

Right.

> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Regards,
Denis
