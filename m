Return-Path: <mhocko@kernel.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40XRr93Hg5zF24D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Apr 2018 18:27:20 +1000 (AEST)
Date: Fri, 27 Apr 2018 10:27:15 +0200
From: Michal Hocko <mhocko@kernel.org>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 David Rientjes <rientjes@google.com>
Subject: Re: OOM killer invoked while still one forth of mem is available
Message-ID: <20180427082715.GD17484@dhcp22.suse.cz>
References: <df1a8c14-bda3-6271-d403-24b88a254b2c@c-s.fr>
 <alpine.DEB.2.21.1804251253240.151692@chino.kir.corp.google.com>
 <296ea83c-2c00-f1d2-3f62-d8ab8b8fb73c@c-s.fr>
 <20180426131154.GQ17484@dhcp22.suse.cz>
 <2706829f-6207-89f7-46e6-d32244305ccb@c-s.fr>
 <20180426190514.GU17484@dhcp22.suse.cz>
 <20180426222917.Horde.cu42u5sTkcbGdcY0VUmclQ1@messagerie.si.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180426222917.Horde.cu42u5sTkcbGdcY0VUmclQ1@messagerie.si.c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu 26-04-18 22:29:17, LEROY Christophe wrote:
> Michal Hocko <mhocko@kernel.org> a écrit :
[...]
> > Yes, show_migration_types. But I do not see why unmovable pageblocks
> > should block the allocation. This is a GFP_KERNEL allocation request
> > essentially - thus unmovable itself. This smells like a bug. We are way
> > above reserves which could block the allocation.
> 
> Any suggestion on how to investigate that bug ? Anything to trace ?

try to enable allocator and vmscan tracepoints. Maybe it will tell
something.
-- 
Michal Hocko
SUSE Labs
