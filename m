Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8g1Z1kXwzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 11:40:34 +1100 (AEDT)
In-Reply-To: <897d01cca8cd61a42493a4f6ba6bfca056419686.1484326337.git.naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 daniel@iogearbox.net, ast@fb.com
Subject: Re: [2/3] powerpc: bpf: flush the entire JIT buffer
Message-Id: <3v8g1Y720jz9t25@ozlabs.org>
Date: Fri, 27 Jan 2017 11:40:33 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-01-13 at 17:10:01 UTC, "Naveen N. Rao" wrote:
> With bpf_jit_binary_alloc(), we allocate at a page granularity and fill
> the rest of the space with illegal instructions to mitigate BPF spraying
> attacks, while having the actual JIT'ed BPF program at a random location
> within the allocated space. Under this scenario, it would be better to
> flush the entire allocated buffer rather than just the part containing
> the actual program. We already flush the buffer from start to the end of
> the BPF program. Extend this to include the illegal instructions after
> the BPF program.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/10528b9c45cfb9e8f45217ef2f5ef8

cheers
