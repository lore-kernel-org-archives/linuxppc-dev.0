Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spfzs2tlfzDrKS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 13:36:25 +1100 (AEDT)
In-Reply-To: <40b65ab2bb3a48837ab047a70887de3ccd70c56b.1474661927.git.naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@fb.com>
Subject: Re: [1/3] bpf powerpc: introduce accessors for using the tmp local
 stack space
Message-Id: <3spfzs0whCz9rxw@ozlabs.org>
Date: Wed,  5 Oct 2016 13:36:24 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-23-09 at 20:35:00 UTC, "Naveen N. Rao" wrote:
> While at it, ensure that the location of the local save area is
> consistent whether or not we setup our own stackframe. This property is
> utilised in the next patch that adds support for tail calls.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7b847f523fe07b4ad73a01cec49a4d

cheers
