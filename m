Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWlys39gnzDq78
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 10:30:13 +1100 (AEDT)
In-Reply-To: <20170901185301.17978-1-sandipan@linux.vnet.ibm.com>
To: Sandipan Das <sandipan@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: netdev@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, daniel@iogearbox.net, ast@fb.com
Subject: Re: [1/1] bpf: take advantage of stack_depth tracking in powerpc JIT
Message-Id: <3yWlys2R6yz9s7F@ozlabs.org>
Date: Wed,  8 Nov 2017 10:30:13 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-09-01 at 18:53:01 UTC, Sandipan Das wrote:
> Take advantage of stack_depth tracking, originally introduced for
> x64, in powerpc JIT as well. Round up allocated stack by 16 bytes
> to make sure it stays aligned for functions called from JITed bpf
> program.
> 
> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
> Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ac0761ebcb08830d8f64b9181f6736

cheers
