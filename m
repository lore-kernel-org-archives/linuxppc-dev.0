Return-Path: <kda@linux-powerpc.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 862041A00AE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 17:58:24 +1100 (AEDT)
Received: from mail-yk0-f169.google.com (mail-yk0-f169.google.com
 [209.85.160.169])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EF24614011D
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2014 17:58:23 +1100 (AEDT)
Received: by mail-yk0-f169.google.com with SMTP id 79so3094002ykr.28
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2014 22:58:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1416275444.1107.4.camel@concordia>
References: <1416254861-3879-1-git-send-email-kda@linux-powerpc.org>
 <1416275444.1107.4.camel@concordia>
Date: Tue, 18 Nov 2014 10:58:20 +0400
Message-ID: <CAOJe8K0_u51QkKmVoVmFuGaDtKfcHP6tSWx_fgJM_erRRoQfUA@mail.gmail.com>
Subject: Re: [PATCH net-next] PPC: bpf_jit_comp: Unify BPF_MOD | BPF_X and
 BPF_DIV | BPF_X
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>, netdev@vger.kernel.org,
 Daniel Borkmann <dborkman@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

This patch added no new functionality so I haven't put the test
results (of course I ran the test suite to check the patch).

The output :
[  650.198958] test_bpf: Summary: 60 PASSED, 0 FAILED

On 11/18/14, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Mon, 2014-11-17 at 23:07 +0300, Denis Kirjanov wrote:
>> Reduce duplicated code by unifying
>> BPF_ALU | BPF_MOD | BPF_X and BPF_ALU | BPF_DIV | BPF_X
>>
>> CC: Alexei Starovoitov<alexei.starovoitov@gmail.com>
>> CC: Daniel Borkmann<dborkman@redhat.com>
>> CC: Philippe Bergheaud<felix@linux.vnet.ibm.com>
>> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
>
> Please include the output of the test suite.
>
> Assuming that's OK I'm happy for it to go in.
>
> cheers
>
>
>
>
