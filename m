Return-Path: <srs0=rsks=do=suse.de=msuchanek@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0p7G6mdwzDqXs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 04:34:18 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3z0p7G4w78z8v71
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 04:34:18 +1100 (AEDT)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3z0p7G0TT3z9s7m
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2017 04:34:17 +1100 (AEDT)
Date: Mon, 18 Dec 2017 18:34:13 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>, Andrew Morton <akpm@linux-foundation.org>, Ankit
 Kumar <ankit@linux.vnet.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH] Fix parse_args cycle limit check.
Message-ID: <20171218183413.53358649@kitsune.suse.cz>
In-Reply-To: <12296c9b-d215-20d4-843e-4c9c9c06f0be@infradead.org>
References: <20171215214702.7c7afba1@kitsune.suse.cz>
 <20171215214149.3692-1-msuchanek@suse.de>
 <12296c9b-d215-20d4-843e-4c9c9c06f0be@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 15 Dec 2017 15:49:09 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 12/15/2017 01:41 PM, Michal Suchanek wrote:
> > Actually args are supposed to be renamed to next so both and args
> > hold the previous argument so both can be passed to the callback.
> > This additionla patch  
> 
>                                                                 additional
> 
> > should fix up the rename.  
> 
> Would you try rewriting the first sentence, please? I don't get it.

Ok, I guess this should be clarified. For the original patch and the
fixup squashed together this is what the patch is supposed to do:

This patch adds variable for tracking the parameter which is currently
being processed. There is "args" variable which tracks the parameter
which will be processed next so this patch adds "next" variable to
track that and uses "args" to track the current argument.

Thanks

Michal
