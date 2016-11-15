Return-Path: <htejun@gmail.com>
Received: from mail-yb0-x244.google.com (mail-yb0-x244.google.com
 [IPv6:2607:f8b0:4002:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJBTq0qctzDt3c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 02:42:23 +1100 (AEDT)
Received: by mail-yb0-x244.google.com with SMTP id h184so4045017ybb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 07:42:23 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 15 Nov 2016 10:42:19 -0500
From: Tejun Heo <tj@kernel.org>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 akpm@linux-foundation.org
Subject: Re: [v1 0/3] Support memory cgroup hotplug
Message-ID: <20161115154219.GA28262@htj.duckdns.org>
References: <1479167045-28136-1-git-send-email-bsingharora@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479167045-28136-1-git-send-email-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, Balbir.

On Tue, Nov 15, 2016 at 10:44:02AM +1100, Balbir Singh wrote:
> In the absence of hotplug we use extra memory proportional to
> (possible_nodes - online_nodes) * number_of_cgroups. PPC64 has a patch
> to disable large consumption with large number of cgroups. This patch
> adds hotplug support to memory cgroups and reverts the commit that
> limited possible nodes to online nodes.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Can you please cc memcg maintainers?  Johannes Weiner
<hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org> and Vladimir
Davydov <vdavydov.dev@gmail.com>.

Thanks.

-- 
tejun
