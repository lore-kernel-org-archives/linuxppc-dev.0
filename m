Return-Path: <daniel@iogearbox.net>
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qffYW2JBnzDq6L
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 05:48:47 +1000 (AEST)
Message-ID: <57041696.1050201@iogearbox.net>
Date: Tue, 05 Apr 2016 21:48:38 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
MIME-Version: 1.0
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
CC: Alexei Starovoitov <ast@fb.com>, "David S. Miller" <davem@davemloft.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH net 4/4] lib/test_bpf: Add additional BPF_ADD tests
References: <5e3cf7c4a971e6d2ff7a2d50bbec2e6e26883b84.1459850410.git.naveen.n.rao@linux.vnet.ibm.com>
 <9b71e280481a9f84cd7dbb9e767fd08e6f4c0aef.1459850410.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <9b71e280481a9f84cd7dbb9e767fd08e6f4c0aef.1459850410.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/05/2016 12:02 PM, Naveen N. Rao wrote:
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

Thanks for adding these!

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
