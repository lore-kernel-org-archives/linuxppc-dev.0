Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8g1Y1BRGzDq6j
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 11:40:33 +1100 (AEDT)
In-Reply-To: <e73efe6facf6c06932b4a87707e5978172ee773e.1484326337.git.naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 daniel@iogearbox.net, ast@fb.com
Subject: Re: [1/3] powerpc: bpf: remove redundant check for non-null image
Message-Id: <3v8g1Y0Dnjz9t1Q@ozlabs.org>
Date: Fri, 27 Jan 2017 11:40:33 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-01-13 at 17:10:00 UTC, "Naveen N. Rao" wrote:
> From: Daniel Borkmann <daniel@iogearbox.net>
> 
> We have a check earlier to ensure we don't proceed if image is NULL. As
> such, the redundant check can be removed.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> [Added similar changes for classic BPF JIT]
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Acked-by: Alexei Starovoitov <ast@kernel.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/052de33ca4f840bf35587eacdf78b3

cheers
