Return-Path: <alexei.starovoitov@gmail.com>
Received: from mail-qg0-x236.google.com (mail-qg0-x236.google.com
 [IPv6:2607:f8b0:400d:c04::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E6D7E1A0409
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 02:03:04 +1100 (AEDT)
Received: by mail-qg0-f54.google.com with SMTP id z60so23601878qgd.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 07:03:01 -0800 (PST)
MIME-Version: 1.0
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 16 Feb 2015 10:02:40 -0500
Message-ID: <CAADnVQJ2kONF03avXmcvKpwTaZ74wOLzcTjTOLKt1=XoY01Yqg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/6] bpf: Enable BPF JIT on ppc32
To: Denis Kirjanov <kda@linux-powerpc.org>
Content-Type: text/plain; charset=UTF-8
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 16, 2015 at 2:13 AM, Denis Kirjanov <kda@linux-powerpc.org> wrote:
> On 2/15/15, Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 02/15/2015 07:06 PM, Denis Kirjanov wrote:
>>> This patch series enables BPF JIT on ppc32. There are relatevily
>>> few chnages in the code to make it work.
>>>
>>> All test_bpf tests passed both on 7447a and P2041-based machines.
>>
>> I'm just wondering, next to the feedback that has already been
>> provided, would opening this up for ppc32 make it significantly
>> more difficult in future to migrate from classic BPF JIT to eBPF
>> JIT eventually (which is what we want long-term)? Being curious,
>> is there any ongoing effort from ppc people?
>>
>
> Well, I don't see significant challenges to enable eBPF on ppc64 in the future.
> I'll start working on it after I get this merged

sounds great. looking forward to it :)
