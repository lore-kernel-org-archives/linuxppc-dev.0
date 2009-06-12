Return-Path: <paulus@bilbo.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18993.42761.401143.92106@cargo.ozlabs.ibm.com>
Date: Fri, 12 Jun 2009 10:53:29 +1000
From: Paul Mackerras <paulus@samba.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: origin tree build failure
In-Reply-To: <20090612102427.32582baa.sfr@canb.auug.org.au>
References: <20090612102427.32582baa.sfr@canb.auug.org.au>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Linus <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>, ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stephen Rothwell writes:

> Subject: [PATCH] perfcounters: remove powerpc definitions of perf_counter_do_pending
> 
> Commit 925d519ab82b6dd7aca9420d809ee83819c08db2 ("perf_counter:
> unify and fix delayed counter wakeup") added global definitions.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Paul Mackerras <paulus@samba.org>
