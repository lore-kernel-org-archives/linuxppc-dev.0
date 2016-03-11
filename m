Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8358F1A02EE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Mar 2016 11:30:42 +1100 (AEDT)
In-Reply-To: <1452552926-17494-1-git-send-email-sukadev@linux.vnet.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [1/2] powerpc/perf: Remove PME_ prefix for power7 events
Message-Id: <20160311003042.4C74F140C3B@ozlabs.org>
Date: Fri, 11 Mar 2016 11:30:42 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-11-01 at 22:55:25 UTC, Sukadev Bhattiprolu wrote:
> We used the PME_ prefix earlier to avoid some macro/variable name
> collisions.  We have since changed the way we define/use the event
> macros so we no longer need the prefix.
> 
> By dropping the prefix, we keep the the event macros consistent with
> their official names.
> 
> Reported-by: Michael Ellerman <ellerman@au1.ibm.com>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d4969e2459c6e852a6862256cf

cheers
