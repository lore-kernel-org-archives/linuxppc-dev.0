Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E66C52C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 19:59:57 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Wed, 24 Jul 2013 15:24:04 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 30BCEE004F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 15:29:49 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6OA0eix23396362
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 15:30:40 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6O9xh2j005669
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 09:59:44 GMT
Message-ID: <51EFA559.9050601@linux.vnet.ibm.com>
Date: Wed, 24 Jul 2013 15:28:49 +0530
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/3] cpuidle/powernv: cpuidle backend driver for powernv
References: <20130723090111.7291.99479.stgit@deepthi.in.ibm.com>
 <20130723090137.7291.36657.stgit@deepthi.in.ibm.com>
 <20130723140645.GI31944@concordia>
In-Reply-To: <20130723140645.GI31944@concordia>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-pm@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/23/2013 07:36 PM, Michael Ellerman wrote:
> On Tue, Jul 23, 2013 at 02:31:41PM +0530, Deepthi Dharwar wrote:
>> This patch implements a back-end cpuidle driver for
>> powernv calling power7_nap and snooze idle states.
>> This can be extended by adding more idle states
>> in the future to the existing framework.
> 
> Other than the state table and a few minor details this looks almost
> identical to the pseries driver. Can we not have a single version in
> sysdev and isolate just the differences?
>

Hi Michael,

Yes, I was actually looking at consolidating and moving all the powerpc
cpuidle driver code to drivers/cpuidle/. sysdev also seems fine. Let me
redo and club the drivers and have a single version of the code in
sysdev for both powerpc and powernv platforms.

Thanks !
Deepthi


> cheers
> 
