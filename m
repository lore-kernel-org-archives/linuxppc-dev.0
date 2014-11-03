Return-Path: <alexei.starovoitov@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 765481A01B7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Nov 2014 04:21:06 +1100 (AEDT)
MIME-Version: 1.0
In-Reply-To: <20141103.120633.183870310578884991.davem@davemloft.net>
References: <1414649535-3956-1-git-send-email-kda@linux-powerpc.org>
 <20141103.120633.183870310578884991.davem@davemloft.net>
Date: Mon, 3 Nov 2014 09:21:03 -0800
Message-ID: <CAADnVQJYNB15cQvDi0+AcL==n+f8PAb1=Dnp_vBWku4SA-Q_6Q@mail.gmail.com>
Subject: Re: [PATCH v2] PPC: bpf_jit_comp: add SKF_AD_PKTTYPE instruction
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: David Miller <davem@davemloft.net>, felix@linux.vnet.ibm.com
Content-Type: text/plain; charset=UTF-8
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

On Mon, Nov 3, 2014 at 9:06 AM, David Miller <davem@davemloft.net> wrote:
> From: Denis Kirjanov <kda@linux-powerpc.org>
> Date: Thu, 30 Oct 2014 09:12:15 +0300
>
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
>>
>> CC: Alexei Starovoitov<alexei.starovoitov@gmail.com>
>> CC: Michael Ellerman<mpe@ellerman.id.au>
>> Cc: Matt Evans <matt@ozlabs.org>
>> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
>>
>> v2: Added test rusults
>
> So, can I apply this now?

I think this question is more towards ppc folks,
since both Daniel and myself said before that it looks ok.
Philippe just tested the previous version of this patch on ppc64le...
I'm guessing that Matt (original author of bpf jit for ppc) is not replying,
because he has no objections.
Either way the addition is tiny and contained, so can go in now.
