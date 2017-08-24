Return-Path: <clg@kaod.org>
Received: from 7.mo179.mail-out.ovh.net (7.mo179.mail-out.ovh.net
 [46.105.61.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdGqM3Ws8zDqXc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 17:57:35 +1000 (AEST)
Received: from player794.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 56E025AC54
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 09:37:49 +0200 (CEST)
Subject: Re: [PATCH 10/10] powerpc/xive: fix the size of the cpumask used in
 xive_find_target_in_mask()
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <1502182969-3180-1-git-send-email-clg@kaod.org>
 <874lthnrse.fsf@concordia.ellerman.id.au>
 <87r2w1wm4g.fsf@concordia.ellerman.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <114fe3a9-1466-9ba4-aa87-a5a9848b1678@kaod.org>
Date: Thu, 24 Aug 2017 09:37:43 +0200
MIME-Version: 1.0
In-Reply-To: <87r2w1wm4g.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/24/2017 07:49 AM, Michael Ellerman wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> 
>> Cédric Le Goater <clg@kaod.org> writes:
>>> When called from xive_irq_startup(), the size of the cpumask can be
>>> larger than nr_cpu_ids. Most of time, its value is NR_CPUS (2048).
> ...
>>
>> I guess this patch is a good fix, I'll expand the change log a bit.
> 
> Actually this got lost, because it was part of the larger series, and
> then you sent a v2 of the series and so v1 was marked superseeded :/
> 
> Anyway I've pulled this out of the series and will merge it.

I just saw your resend. Thanks for doing so,

C.
