Return-Path: <davem@davemloft.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C59621A0179
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Nov 2014 07:30:05 +1100 (AEDT)
Date: Mon, 03 Nov 2014 15:29:58 -0500 (EST)
Message-Id: <20141103.152958.2144581734281584875.davem@davemloft.net>
To: alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2] PPC: bpf_jit_comp: add SKF_AD_PKTTYPE instruction
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAADnVQJYNB15cQvDi0+AcL==n+f8PAb1=Dnp_vBWku4SA-Q_6Q@mail.gmail.com>
References: <1414649535-3956-1-git-send-email-kda@linux-powerpc.org>
 <20141103.120633.183870310578884991.davem@davemloft.net>
 <CAADnVQJYNB15cQvDi0+AcL==n+f8PAb1=Dnp_vBWku4SA-Q_6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: matt@ozlabs.org, netdev@vger.kernel.org, kda@linux-powerpc.org,
 linuxppc-dev@ozlabs.org, felix@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 3 Nov 2014 09:21:03 -0800

> On Mon, Nov 3, 2014 at 9:06 AM, David Miller <davem@davemloft.net> wrote:
>> From: Denis Kirjanov <kda@linux-powerpc.org>
>> Date: Thu, 30 Oct 2014 09:12:15 +0300
>>
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
>>>
>>> CC: Alexei Starovoitov<alexei.starovoitov@gmail.com>
>>> CC: Michael Ellerman<mpe@ellerman.id.au>
>>> Cc: Matt Evans <matt@ozlabs.org>
>>> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
>>>
>>> v2: Added test rusults
>>
>> So, can I apply this now?
> 
> I think this question is more towards ppc folks,
> since both Daniel and myself said before that it looks ok.
> Philippe just tested the previous version of this patch on ppc64le...
> I'm guessing that Matt (original author of bpf jit for ppc) is not replying,
> because he has no objections.
> Either way the addition is tiny and contained, so can go in now.

Ok, I have applied this to net-next, thanks everyone.
