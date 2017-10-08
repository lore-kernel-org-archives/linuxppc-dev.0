Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y8xjb6GSfzDqG2
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Oct 2017 19:43:31 +1100 (AEDT)
In-Reply-To: <1461061101-31196-1-git-send-email-kautuk.consul.1980@gmail.com>
To: Kautuk Consul <kautuk.consul.1980@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Cyril Bur <cyrilbur@gmail.com>, Michael Neuling <mikey@neuling.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Kautuk Consul <kautuk.consul.1980@gmail.com>
Subject: Re: [1/1] powerpc: get_wchan(): solve possible race scenario due to
 parallel wakeup
Message-Id: <3y8xjb4YPnz9t4R@ozlabs.org>
Date: Sun,  8 Oct 2017 19:43:31 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-04-19 at 10:18:21 UTC, Kautuk Consul wrote:
> Add a check for p->state == TASK_RUNNING so that any wake-ups on
> task_struct p in the interim lead to 0 being returned by get_wchan().
> 
> Signed-off-by: Kautuk Consul <kautuk.consul.1980@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4ca360f3dbf2036d964cdf3a6c4a45

cheers
