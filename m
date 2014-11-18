Return-Path: <davem@davemloft.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0EA4E1A09C0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 05:20:51 +1100 (AEDT)
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id C0B1B1400DE
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2014 05:20:50 +1100 (AEDT)
Date: Tue, 18 Nov 2014 13:20:42 -0500 (EST)
Message-Id: <20141118.132042.1805477418902433426.davem@davemloft.net>
To: alexei.starovoitov@gmail.com
Subject: Re: [PATCH net-next] PPC: bpf_jit_comp: Unify BPF_MOD | BPF_X and
 BPF_DIV | BPF_X
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAADnVQ+w9=aezS9uCursLS4Q40S4jcyn=5vNhoc-n5qcyrF0wQ@mail.gmail.com>
References: <1416275444.1107.4.camel@concordia>
 <CAOJe8K0_u51QkKmVoVmFuGaDtKfcHP6tSWx_fgJM_erRRoQfUA@mail.gmail.com>
 <CAADnVQ+w9=aezS9uCursLS4Q40S4jcyn=5vNhoc-n5qcyrF0wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: kda@linux-powerpc.org, linuxppc-dev@ozlabs.org, dborkman@redhat.com,
 netdev@vger.kernel.org, felix@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 18 Nov 2014 07:37:21 -0800

> On Mon, Nov 17, 2014 at 10:58 PM, Denis Kirjanov <kda@linux-powerpc.org> wrote:
>> Hi Michael,
>>
>> This patch added no new functionality so I haven't put the test
>> results (of course I ran the test suite to check the patch).
>>
>> The output :
>> [  650.198958] test_bpf: Summary: 60 PASSED, 0 FAILED
> 
> Acked-by: Alexei Starovoitov <ast@plumgrid.com>

Applied, thanks everyone.

> btw, please don't top post.

Seriously, it's my biggest pet peeve.  It's like going to a dinner party
and eating with your feet.
