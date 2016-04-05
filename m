Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qfZg42fcXzDq6b
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 02:53:20 +1000 (AEST)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 6 Apr 2016 02:53:19 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2B1CB3578056
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 02:53:16 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u35Gr7Tl11469220
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 02:53:16 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u35GqgNc015829
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 02:52:43 +1000
Date: Tue, 5 Apr 2016 22:21:47 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Alexei Starovoitov <ast@fb.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH net 4/4] lib/test_bpf: Add additional BPF_ADD tests
Message-ID: <20160405165147.GC15993@naverao1-tp.in.ibm.com>
References: <5e3cf7c4a971e6d2ff7a2d50bbec2e6e26883b84.1459850410.git.naveen.n.rao@linux.vnet.ibm.com>
 <9b71e280481a9f84cd7dbb9e767fd08e6f4c0aef.1459850410.git.naveen.n.rao@linux.vnet.ibm.com>
 <5703E7B2.6050706@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5703E7B2.6050706@fb.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/04/05 09:28AM, Alexei Starovoitov wrote:
> On 4/5/16 3:02 AM, Naveen N. Rao wrote:
> >Some of these tests proved useful with the powerpc eBPF JIT port due to
> >sign-extended 16-bit immediate loads. Though some of these aspects get
> >covered in other tests, it is better to have explicit tests so as to
> >quickly tag the precise problem.
> >
> >Cc: Alexei Starovoitov <ast@fb.com>
> >Cc: Daniel Borkmann <daniel@iogearbox.net>
> >Cc: "David S. Miller" <davem@davemloft.net>
> >Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> >Cc: Michael Ellerman <mpe@ellerman.id.au>
> >Cc: Paul Mackerras <paulus@samba.org>
> >Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> 
> Makes sense. Looks like ppc jit will be using quite a bit of
> available ppc instructions. Nice.
> 
> I'm assuming all these new tests passed with x64 jit?

Yes, all these tests pass on x86_64.

- Naveen
