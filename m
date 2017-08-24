Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdCzz32PtzDrL1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 15:49:51 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@samba.org>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 10/10] powerpc/xive: fix the size of the cpumask used in
 xive_find_target_in_mask()
In-Reply-To: <874lthnrse.fsf@concordia.ellerman.id.au>
References: <1502182969-3180-1-git-send-email-clg@kaod.org>
 <874lthnrse.fsf@concordia.ellerman.id.au>
Date: Thu, 24 Aug 2017 15:49:51 +1000
Message-ID: <87r2w1wm4g.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>> When called from xive_irq_startup(), the size of the cpumask can be
>> larger than nr_cpu_ids. Most of time, its value is NR_CPUS (2048).
...
>
> I guess this patch is a good fix, I'll expand the change log a bit.

Actually this got lost, because it was part of the larger series, and
then you sent a v2 of the series and so v1 was marked superseeded :/

Anyway I've pulled this out of the series and will merge it.

cheers
