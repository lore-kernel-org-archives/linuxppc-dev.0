Return-Path: <hughd@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8581AB6FBA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jun 2011 07:00:44 +1000 (EST)
Received: from wpaz5.hot.corp.google.com (wpaz5.hot.corp.google.com
	[172.24.198.69]) by smtp-out.google.com with ESMTP id p5DL0cBa029283
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2011 14:00:38 -0700
Received: from yia25 (yia25.prod.google.com [10.243.65.25])
	by wpaz5.hot.corp.google.com with ESMTP id p5DL0VFO022129
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2011 14:00:32 -0700
Received: by yia25 with SMTP id 25so1559703yia.4
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Jun 2011 14:00:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <BANLkTi=RYq0Dd210VC+NeTXWWuFbz7cxeg@mail.gmail.com>
References: <alpine.LSU.2.00.1106121842250.31463@sister.anvils>
	<alpine.DEB.2.00.1106131258300.3108@router.home>
	<1307990048.11288.3.camel@jaguar>
	<alpine.DEB.2.00.1106131428560.5601@router.home>
	<BANLkTi=RYq0Dd210VC+NeTXWWuFbz7cxeg@mail.gmail.com>
Date: Mon, 13 Jun 2011 14:00:31 -0700
Message-ID: <BANLkTik-KGtuoVFKvy_rk7voBRAxSsR9FRg0fhb0k3NCSg-fWQ@mail.gmail.com>
Subject: Re: [PATCH] slub: fix kernel BUG at mm/slub.c:1950!
From: Hugh Dickins <hughd@google.com>
To: Pekka Enberg <penberg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: linux-mm <linux-mm@kvack.org>, Christoph Lameter <cl@linux.com>,
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

On Mon, Jun 13, 2011 at 1:34 PM, Pekka Enberg <penberg@kernel.org> wrote:
> On Mon, Jun 13, 2011 at 10:29 PM, Christoph Lameter <cl@linux.com> wrote:
>> On Mon, 13 Jun 2011, Pekka Enberg wrote:
>>
>>> > Hmmm.. The allocpercpu in alloc_kmem_cache_cpus should take care of the
>>> > alignment. Uhh.. I see that a patch that removes the #ifdef CMPXCHG_LOCAL
>>> > was not applied? Pekka?
>>>
>>> This patch?
>>>
>>> http://git.kernel.org/?p=linux/kernel/git/penberg/slab-2.6.git;a=commitdiff;h=d4d84fef6d0366b585b7de13527a0faeca84d9ce
>>>
>>> It's queued and will be sent to Linus soon.
>>
>> Ok it will also fix Hugh's problem then.
>
> It's in Linus' tree now. Hugh, can you please confirm it fixes your machine too?

I expect it to, thanks: I'll confirm tonight.

Hugh
