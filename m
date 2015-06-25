Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3FA591A06A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 13:36:12 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Wed, 24 Jun 2015 21:36:10 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 88E333E40044
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 21:36:08 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5P3Xi2P16842752
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 20:33:44 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5P3a6iY010973
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 21:36:07 -0600
Message-ID: <558B7715.1060802@linux.vnet.ibm.com>
Date: Thu, 25 Jun 2015 09:05:49 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Mark Rutland <mark.rutland@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Will Deacon <will.deacon@arm.com>, shreyas@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] tick/idle/powerpc: Do not register idle states with
 CPUIDLE_FLAG_TIMER_STOP set in periodic mode
References: <20150624064801.30680.3246.stgit@perfhull-ltc.austin.ibm.com>
 <1700583.a34yOllUuC@vostro.rjw.lan>
 <1435183570.3790.15.camel@kernel.crashing.org>
 <CAJZ5v0hiKVN7Nvc4w3BP9uWmvdUkX6T+DUGh6OSZWPTrpwcyjA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hiKVN7Nvc4w3BP9uWmvdUkX6T+DUGh6OSZWPTrpwcyjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/25/2015 05:36 AM, Rafael J. Wysocki wrote:
> On Thu, Jun 25, 2015 at 12:06 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
>> On Wed, 2015-06-24 at 15:50 +0200, Rafael J. Wysocki wrote:
>>> 4.2 material I suppose?
>>
>> And stable. Without this, if you configure without TICK_ONESHOT, the
>> machine will hang.
> 
> OK, which -stable?  All of them or any specific series?

This needs to go into stable/linux-3.19.y,
stable/linux-4.0.y, stable/linux-4.1.y.

Thanks

Regards
Preeti U Murthy
> 
> Rafael
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
