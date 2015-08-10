Return-Path: <stewart@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 03E4E1A0CDB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 18:19:17 +1000 (AEST)
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0D4691401AF
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2015 18:19:15 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 10 Aug 2015 04:19:13 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id B6E0A6E801D
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2015 04:10:56 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7A8JBea45154418
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2015 08:19:11 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7A8JAqt010418
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2015 04:19:11 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, viresh.kumar@linaro.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, joel@jms.id.au
Subject: Re: [PATCH v5 3/6] cpufreq: powernv: Register for OCC related
 opal_message notification
In-Reply-To: <55C857F8.6090502@linux.vnet.ibm.com>
References: <1437033863-15864-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1437033863-15864-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <m3y4hjex8q.fsf@oc8180480414.ibm.com> <55C857F8.6090502@linux.vnet.ibm.com>
Date: Mon, 10 Aug 2015 18:19:08 +1000
Message-ID: <m3zj1zd08z.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:
>> Also, do we export this information via sysfs somewhere? It would seem
>> to want to go along with other cpufreq/cpu info there.
>
> No we don't export the throttling status of the cpu via sysfs. Since the
> throttling state is common across the chip, the per_cpu export will be
> redundant. Did you mean something like one of the below:
>
> 1)/sys/devices/system/cpu/cpufreq/chipN_throttle
>
> 2)/sys/devices/system/cpu/cpuN/cpufreq/throttle

yeah, I was thinking something like that.
