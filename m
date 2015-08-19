Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D1D651A0514
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 18:42:35 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Wed, 19 Aug 2015 14:12:33 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 14B8FE0058
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 14:11:50 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7J8gSFw50200792
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 14:12:28 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7J8gRhT007212
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 14:12:28 +0530
Message-ID: <55D44173.9020700@linux.vnet.ibm.com>
Date: Wed, 19 Aug 2015 14:12:27 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linux-leds@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, j.anaszewski@samsung.com
CC: stewart@linux.vnet.ibm.com, j.anaszewski81@gmail.com, arnd@arndb.de,
 cooloney@gmail.com, rpurdie@rpsys.net, khandual@linux.vnet.ibm.com
Subject: Re: [v8,3/3] leds/powernv: Add driver for PowerNV platform
References: <20150818102136.0C9DD1402B5@ozlabs.org>
In-Reply-To: <20150818102136.0C9DD1402B5@ozlabs.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/18/2015 03:51 PM, Michael Ellerman wrote:
> On Sat, 2015-25-07 at 05:21:10 UTC, Vasant Hegde wrote:
>> This patch implements LED driver for PowerNV platform using the existing
>> generic LED class framework.
>>
>> PowerNV platform has below type of LEDs:
>>   - System attention
>>       Indicates there is a problem with the system that needs attention.
>>   - Identify
>>       Helps the user locate/identify a particular FRU or resource in the
>>       system.
>>   - Fault
>>       Indicates there is a problem with the FRU or resource at the
>>       location with which the indicator is associated.
> 
> Hi Vasant,
> 
> I'm waiting for a respin of this based on the discussion between you and
> Jackek.
> 
> If I don't see it soon it will miss v4.3.

Michael,

I'll post v9 in a day or two.

-Vasant
