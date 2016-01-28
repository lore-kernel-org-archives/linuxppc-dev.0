Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 34BED1A030F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 20:55:57 +1100 (AEDT)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F3FCB140BAE
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 20:55:56 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 28 Jan 2016 19:55:56 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 52752357805A
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 20:55:53 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0S9tjr665208548
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 20:55:53 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0S9tKqD009925
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 20:55:20 +1100
Message-ID: <56A9E56C.1050505@linux.vnet.ibm.com>
Date: Thu, 28 Jan 2016 15:24:52 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
 linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org,
 ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com,
 bsingharora@gmail.com, mpe@ellerman.id.au, linux-api@vger.kernel.org
Subject: Re: [PATCH v7 6/6] cpufreq: powernv: Add sysfs attributes to show
 throttle stats
References: <1453965941-7363-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1453965941-7363-7-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20160128084041.GK3935@vireshk> <56A9E136.8090900@linux.vnet.ibm.com>
 <20160128094146.GO3935@vireshk>
In-Reply-To: <20160128094146.GO3935@vireshk>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 01/28/2016 03:11 PM, Viresh Kumar wrote:
> On 28-01-16, 15:06, Shilpasri G Bhat wrote:
>> No these stats are not per-policy. They are per-chip. The throttle event is
>> common for all cores in the chip.
> 
> How do you define a chip? And how is it different then the group of
> CPUs represented by the policy ?
> 

Chip is a group of policies.
Hmm yes I see your point. We anyways maintain frequency stats which is
per-policy. We might as well have throttle stats exported per-policy which
points to per-chip data.
