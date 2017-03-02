Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x22f.google.com (mail-pf0-x22f.google.com
 [IPv6:2607:f8b0:400e:c00::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYpQ16WjLzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 21:26:33 +1100 (AEDT)
Received: by mail-pf0-x22f.google.com with SMTP id w189so20907017pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Mar 2017 02:26:33 -0800 (PST)
Subject: Re: [PATCH 5/5] powerpc/smp: Add Power9 scheduler topology
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20170302004920.21948-1-oohall@gmail.com>
 <20170302004920.21948-5-oohall@gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <3ef222c7-15f7-e981-394d-61cf4b26a1cc@gmail.com>
Date: Thu, 2 Mar 2017 21:25:59 +1100
MIME-Version: 1.0
In-Reply-To: <20170302004920.21948-5-oohall@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 02/03/17 11:49, Oliver O'Halloran wrote:
> In previous generations of Power processors each core had a private L2
> cache. The Power9 processor has a slightly different architecture where
> the L2 cache is shared among pairs of cores rather than being completely
> private.
> 
> Making the scheduler aware of this cache sharing allows the scheduler to
> make more intelligent migration decisions. When one core in the pair is
> overloaded tasks can be migrated to its paired core to improve throughput
> without cache-refilling penality typically associated with task
> migration.

Could you please describe the changes to sched_domains w.r.t before and
after for P9.

I think most of the changes make sense, but some data to back them up
including any results you have to show that these patches help would be
nice

Balbir Singh.
