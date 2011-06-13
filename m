Return-Path: <penberg@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B202FB6F97
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jun 2011 06:34:26 +1000 (EST)
Received: by vxi40 with SMTP id 40so4442946vxi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Jun 2011 13:34:22 -0700 (PDT)
MIME-Version: 1.0
Sender: penberg@gmail.com
In-Reply-To: <alpine.DEB.2.00.1106131428560.5601@router.home>
References: <alpine.LSU.2.00.1106121842250.31463@sister.anvils>
	<alpine.DEB.2.00.1106131258300.3108@router.home>
	<1307990048.11288.3.camel@jaguar>
	<alpine.DEB.2.00.1106131428560.5601@router.home>
Date: Mon, 13 Jun 2011 23:34:22 +0300
Message-ID: <BANLkTi=RYq0Dd210VC+NeTXWWuFbz7cxeg@mail.gmail.com>
Subject: Re: [PATCH] slub: fix kernel BUG at mm/slub.c:1950!
From: Pekka Enberg <penberg@kernel.org>
To: Christoph Lameter <cl@linux.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On Mon, Jun 13, 2011 at 10:29 PM, Christoph Lameter <cl@linux.com> wrote:
> On Mon, 13 Jun 2011, Pekka Enberg wrote:
>
>> > Hmmm.. The allocpercpu in alloc_kmem_cache_cpus should take care of the
>> > alignment. Uhh.. I see that a patch that removes the #ifdef CMPXCHG_LOCAL
>> > was not applied? Pekka?
>>
>> This patch?
>>
>> http://git.kernel.org/?p=linux/kernel/git/penberg/slab-2.6.git;a=commitdiff;h=d4d84fef6d0366b585b7de13527a0faeca84d9ce
>>
>> It's queued and will be sent to Linus soon.
>
> Ok it will also fix Hugh's problem then.

It's in Linus' tree now. Hugh, can you please confirm it fixes your machine too?
