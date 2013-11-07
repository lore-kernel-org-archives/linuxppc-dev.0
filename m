Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E75A62C0087
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 16:28:10 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Thu, 7 Nov 2013 10:58:05 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 6B0F9394005A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 10:57:38 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rA75Rw4O46923996
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Nov 2013 10:57:59 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rA75S0G7024034
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Nov 2013 10:58:01 +0530
Message-ID: <527B24D4.30009@linux.vnet.ibm.com>
Date: Thu, 07 Nov 2013 10:57:48 +0530
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH V7 5/7] POWER/cpuidle: Generic POWER CPUIDLE driver
 supporting PSERIES.
References: <20131029110052.31547.82682.stgit@deepthi.in.ibm.com>
 <20131029110148.31547.8944.stgit@deepthi.in.ibm.com>
 <527AAF1D.5080605@linaro.org> <527B13C8.9030602@linux.vnet.ibm.com>
 <1383800462.4776.165.camel@pasglop>
In-Reply-To: <1383800462.4776.165.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 preeti@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com,
 scottwood@freescale.com, linux-pm@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/07/2013 10:31 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2013-11-07 at 09:45 +0530, Deepthi Dharwar wrote:
>> 'powerpc' would be very generic arch and would comprise of all platforms
>> including embedded 32/64 bit to server 64 bit (similar to that of ARM).
>> This driver does not intend to support complete powerpc arch, but just
>> PSERIES and POWERNV platforms termed as 'POWER' processors. So to avoid
>> confusion btw 'power mgmt' and 'POWER' archs, I have prefixed both the
>> driver and file names with 'IBM'namely ibm-power-driver, cpuidle-ibm-power.
> 

Hi Ben,

> Why not book3s ? powerpc-book3s ?

I went with 'ibm-power' thinking it would resolve the confusion,
but if ppl feel that is is good to get away from 'POWER' and have
powerpc-book3s instead to make things clearer, I am open for it.


Regards,
Deepthi

> That's what we use in other places to differenciate between the families
> 
> Ben.
> 
> 
