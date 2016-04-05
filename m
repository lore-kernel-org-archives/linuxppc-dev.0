Return-Path: <prvs=3903de43b8=ast@fb.com>
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qfZ711YRFzDq6S
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 02:29:01 +1000 (AEST)
Subject: Re: [PATCH net 4/4] lib/test_bpf: Add additional BPF_ADD tests
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <netdev@vger.kernel.org>
References: <5e3cf7c4a971e6d2ff7a2d50bbec2e6e26883b84.1459850410.git.naveen.n.rao@linux.vnet.ibm.com>
 <9b71e280481a9f84cd7dbb9e767fd08e6f4c0aef.1459850410.git.naveen.n.rao@linux.vnet.ibm.com>
CC: Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <5703E7B2.6050706@fb.com>
Date: Tue, 5 Apr 2016 09:28:34 -0700
MIME-Version: 1.0
In-Reply-To: <9b71e280481a9f84cd7dbb9e767fd08e6f4c0aef.1459850410.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 4/5/16 3:02 AM, Naveen N. Rao wrote:
> Some of these tests proved useful with the powerpc eBPF JIT port due to
> sign-extended 16-bit immediate loads. Though some of these aspects get
> covered in other tests, it is better to have explicit tests so as to
> quickly tag the precise problem.
>
> Cc: Alexei Starovoitov <ast@fb.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Makes sense. Looks like ppc jit will be using quite a bit of
available ppc instructions. Nice.

I'm assuming all these new tests passed with x64 jit?

Acked-by: Alexei Starovoitov <ast@kernel.org>
