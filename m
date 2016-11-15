Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJPFc2gnFzDvTG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 10:47:32 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id p66so12988479pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 15:47:32 -0800 (PST)
Subject: Re: [v1 0/3] Support memory cgroup hotplug
To: Tejun Heo <tj@kernel.org>
References: <1479167045-28136-1-git-send-email-bsingharora@gmail.com>
 <20161115154219.GA28262@htj.duckdns.org>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 akpm@linux-foundation.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <ac99835c-ae55-f1e2-f449-cd1bd9585806@gmail.com>
Date: Wed, 16 Nov 2016 10:47:26 +1100
MIME-Version: 1.0
In-Reply-To: <20161115154219.GA28262@htj.duckdns.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 16/11/16 02:42, Tejun Heo wrote:
> Hello, Balbir.
> 
> On Tue, Nov 15, 2016 at 10:44:02AM +1100, Balbir Singh wrote:
>> In the absence of hotplug we use extra memory proportional to
>> (possible_nodes - online_nodes) * number_of_cgroups. PPC64 has a patch
>> to disable large consumption with large number of cgroups. This patch
>> adds hotplug support to memory cgroups and reverts the commit that
>> limited possible nodes to online nodes.
>>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
> 
> Can you please cc memcg maintainers?  Johannes Weiner
> <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org> and Vladimir
> Davydov <vdavydov.dev@gmail.com>.
> 
> Thanks.
> 

My bad - resent with copies to the recommended maintainers.

Thanks,
Balbir Singh.
