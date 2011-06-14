Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 58EBFB6F6C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jun 2011 15:00:13 +1000 (EST)
Subject: Re: [PATCH] slub: fix kernel BUG at mm/slub.c:1950!
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hughd@google.com>
In-Reply-To: <BANLkTik-KGtuoVFKvy_rk7voBRAxSsR9FRg0fhb0k3NCSg-fWQ@mail.gmail.com>
References: <alpine.LSU.2.00.1106121842250.31463@sister.anvils>
	<alpine.DEB.2.00.1106131258300.3108@router.home>
	<1307990048.11288.3.camel@jaguar>
	<alpine.DEB.2.00.1106131428560.5601@router.home>
	<BANLkTi=RYq0Dd210VC+NeTXWWuFbz7cxeg@mail.gmail.com>
	<BANLkTik-KGtuoVFKvy_rk7voBRAxSsR9FRg0fhb0k3NCSg-fWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 14 Jun 2011 14:51:18 +1000
Message-ID: <1308027078.2874.1005.camel@pasglop>
Mime-Version: 1.0
Cc: Pekka Enberg <penberg@kernel.org>, linux-mm <linux-mm@kvack.org>,
	Christoph Lameter <cl@linux.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-06-13 at 14:00 -0700, Hugh Dickins wrote:
> On Mon, Jun 13, 2011 at 1:34 PM, Pekka Enberg <penberg@kernel.org> wrote:
> > On Mon, Jun 13, 2011 at 10:29 PM, Christoph Lameter <cl@linux.com> wrote:
> >> On Mon, 13 Jun 2011, Pekka Enberg wrote:
> >>
> >>> > Hmmm.. The allocpercpu in alloc_kmem_cache_cpus should take care of the
> >>> > alignment. Uhh.. I see that a patch that removes the #ifdef CMPXCHG_LOCAL
> >>> > was not applied? Pekka?
> >>>
> >>> This patch?
> >>>
> >>> http://git.kernel.org/?p=linux/kernel/git/penberg/slab-2.6.git;a=commitdiff;h=d4d84fef6d0366b585b7de13527a0faeca84d9ce
> >>>
> >>> It's queued and will be sent to Linus soon.
> >>
> >> Ok it will also fix Hugh's problem then.
> >
> > It's in Linus' tree now. Hugh, can you please confirm it fixes your machine too?
> 
> I expect it to, thanks: I'll confirm tonight.

>From report to resolution before I got to read the thread, that's how I
like them ! Thanks guys :-)

Cheers,
Ben.
