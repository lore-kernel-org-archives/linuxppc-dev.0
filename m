Return-Path: <srs0=vgws=dl=infradead.org=rdunlap@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yz6bd5gZzzDrnB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 10:49:32 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yz6bb6syTz8vj3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 10:49:31 +1100 (AEDT)
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yz6bX014hz9sBW
 for <linuxppc-dev@ozlabs.org>; Sat, 16 Dec 2017 10:49:22 +1100 (AEDT)
Subject: Re: [PATCH] Fix parse_args cycle limit check.
To: Michal Suchanek <msuchanek@suse.de>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ankit Kumar <ankit@linux.vnet.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
References: <20171215214702.7c7afba1@kitsune.suse.cz>
 <20171215214149.3692-1-msuchanek@suse.de>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <12296c9b-d215-20d4-843e-4c9c9c06f0be@infradead.org>
Date: Fri, 15 Dec 2017 15:49:09 -0800
MIME-Version: 1.0
In-Reply-To: <20171215214149.3692-1-msuchanek@suse.de>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/15/2017 01:41 PM, Michal Suchanek wrote:
> Actually args are supposed to be renamed to next so both and args hold the
> previous argument so both can be passed to the callback. This additionla patch

                                                                additional

> should fix up the rename.

Would you try rewriting the first sentence, please? I don't get it.

> ---
>  kernel/params.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)


-- 
~Randy
