Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E7CD01A0913
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 03:24:54 +1100 (AEDT)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F1C18140BFA
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Feb 2016 03:24:53 +1100 (AEDT)
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Wed, 3 Feb 2016 21:54:51 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u13GOnML2556178
 for <linuxppc-dev@ozlabs.org>; Wed, 3 Feb 2016 21:54:49 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u13GOjDD004974
 for <linuxppc-dev@ozlabs.org>; Wed, 3 Feb 2016 21:54:48 +0530
Message-ID: <56B229C9.4010909@linux.vnet.ibm.com>
Date: Wed, 03 Feb 2016 21:54:41 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@rjwysocki.net,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>
CC: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org,
 shreyas@linux.vnet.ibm.com, bsingharora@gmail.com, mpe@ellerman.id.au,
 linux-api@vger.kernel.org
Subject: Re: [PATCH v8 6/6] cpufreq: powernv: Add sysfs attributes to show
 throttle stats
References: <1454442102-1229-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1454442102-1229-7-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20160203082700.GZ31828@vireshk> <56B1BD71.2050403@linux.vnet.ibm.com>
 <20160203090357.GA31828@vireshk> <20160203120258.GA32294@in.ibm.com>
 <20160203140600.GG3469@vireshk>
In-Reply-To: <20160203140600.GG3469@vireshk>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> 
> And now that you have mentioned that to me, why shouldn't this stats
> directory be moved to debugfs ? :)
> 
> We are never going to perform a store here, isn't it ? And is just for
> information, nothing more.
> 

I would very much like to keep the throttle stats either in cpuX/cpufreq or
global cpufreq directory as these are populated by the platform cpufreq driver.

Today we don't have a requirement to a perform a store operation on these files
but we can have it in the future.

Thanks and Regards,
Shilpa
