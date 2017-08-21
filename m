Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xbXHf1dbwzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 21:57:34 +1000 (AEST)
Date: Mon, 21 Aug 2017 21:57:31 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michal Hocko <mhocko@kernel.org>
Cc: Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-next
 <linux-next@vger.kernel.org>, sachinp <sachinp@linux.vnet.ibm.com>, Joonsoo
 Kim <js1304@gmail.com>
Subject: Re: [linux-next][bisected c64e09ce] sysctl command hung indefinitely
Message-ID: <20170821215731.3b32d942@canb.auug.org.au>
In-Reply-To: <20170821075001.GA24530@dhcp22.suse.cz>
References: <1503137971.28497.19.camel@abdul>
 <20170821075001.GA24530@dhcp22.suse.cz>
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

Hi Michal,

On Mon, 21 Aug 2017 09:50:01 +0200 Michal Hocko <mhocko@kernel.org> wrote:
>
> commit 69885605ee3ba681deb54021e3df645f46589ba1
> Author: Michal Hocko <mhocko@suse.com>
> Date:   Mon Aug 21 09:46:04 2017 +0200
> 
>     mmotm: mm-page_alloc-rip-out-zonelist_order_zone-fix
>     
>     Abdul has noticed that reading sysctl vm.numa_zonelist_order
>     read will never terminate. This is because of
>     http://lkml.kernel.org/r/20170714080006.7250-2-mhocko@kernel.org
>     where the reading side doesn't update ppos and so the reader will
>     never get 0. Return back to proc_dostring which does all the necessary
>     stuff.
>     
>     Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
>     Signed-off-by: Michal Hocko <mhocko@suse.com>

I have added that to linux-next for tomorrow.

-- 
Cheers,
Stephen Rothwell
