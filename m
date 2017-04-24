Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBhLM3Tq5zDq66
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 08:47:23 +1000 (AEST)
In-Reply-To: <53bcae5a711eab803c9c3210110e8a464df34202.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@redhat.com>
Subject: Re: [v5,
 2/5] powerpc: kretprobes: override default function entry offset
Message-Id: <3wBhLM2dXMz9s8S@ozlabs.org>
Date: Tue, 25 Apr 2017 08:47:23 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-03-08 at 08:26:07 UTC, "Naveen N. Rao" wrote:
> With ABIv2, we offset 8 bytes into a function to get at the local entry
> point.
> 
> Acked-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a64e3f35a45f4a84148d0ba30a3c75

cheers
