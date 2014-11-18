Return-Path: <alexei.starovoitov@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CE0981A05BE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 02:37:24 +1100 (AEDT)
Received: from mail-qc0-x231.google.com (mail-qc0-x231.google.com
 [IPv6:2607:f8b0:400d:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 425F41400F1
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2014 02:37:24 +1100 (AEDT)
Received: by mail-qc0-f177.google.com with SMTP id x3so3582432qcv.8
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2014 07:37:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOJe8K0_u51QkKmVoVmFuGaDtKfcHP6tSWx_fgJM_erRRoQfUA@mail.gmail.com>
References: <1416254861-3879-1-git-send-email-kda@linux-powerpc.org>
 <1416275444.1107.4.camel@concordia>
 <CAOJe8K0_u51QkKmVoVmFuGaDtKfcHP6tSWx_fgJM_erRRoQfUA@mail.gmail.com>
Date: Tue, 18 Nov 2014 07:37:21 -0800
Message-ID: <CAADnVQ+w9=aezS9uCursLS4Q40S4jcyn=5vNhoc-n5qcyrF0wQ@mail.gmail.com>
Subject: Re: [PATCH net-next] PPC: bpf_jit_comp: Unify BPF_MOD | BPF_X and
 BPF_DIV | BPF_X
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Denis Kirjanov <kda@linux-powerpc.org>
Content-Type: text/plain; charset=UTF-8
Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 Daniel Borkmann <dborkman@redhat.com>, linuxppc-dev@ozlabs.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 17, 2014 at 10:58 PM, Denis Kirjanov <kda@linux-powerpc.org> wrote:
> Hi Michael,
>
> This patch added no new functionality so I haven't put the test
> results (of course I ran the test suite to check the patch).
>
> The output :
> [  650.198958] test_bpf: Summary: 60 PASSED, 0 FAILED

Acked-by: Alexei Starovoitov <ast@plumgrid.com>

btw, please don't top post.
