Return-Path: <cl@linux.com>
Received: from smtp101.prem.mail.ac4.yahoo.com
	(smtp101.prem.mail.ac4.yahoo.com [76.13.13.40])
	by ozlabs.org (Postfix) with SMTP id B5ACCB6FAA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jun 2011 05:29:24 +1000 (EST)
Date: Mon, 13 Jun 2011 14:29:20 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
To: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH] slub: fix kernel BUG at mm/slub.c:1950!
In-Reply-To: <1307990048.11288.3.camel@jaguar>
Message-ID: <alpine.DEB.2.00.1106131428560.5601@router.home>
References: <alpine.LSU.2.00.1106121842250.31463@sister.anvils>
	<alpine.DEB.2.00.1106131258300.3108@router.home>
	<1307990048.11288.3.camel@jaguar>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
	Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 13 Jun 2011, Pekka Enberg wrote:

> > Hmmm.. The allocpercpu in alloc_kmem_cache_cpus should take care of the
> > alignment. Uhh.. I see that a patch that removes the #ifdef CMPXCHG_LOCAL
> > was not applied? Pekka?
>
> This patch?
>
> http://git.kernel.org/?p=linux/kernel/git/penberg/slab-2.6.git;a=commitdiff;h=d4d84fef6d0366b585b7de13527a0faeca84d9ce
>
> It's queued and will be sent to Linus soon.

Ok it will also fix Hugh's problem then.
