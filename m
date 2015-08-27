Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0E5341A05BE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 21:43:25 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Thu, 27 Aug 2015 21:43:23 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3F61C2CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 21:43:21 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7RBh5bk065846
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 21:43:14 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7RBgmaY028600
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 21:42:48 +1000
Message-ID: <55DEF7A5.6070407@linux.vnet.ibm.com>
Date: Thu, 27 Aug 2015 17:12:29 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
CC: j.anaszewski@samsung.com, linux-leds@vger.kernel.org,
 Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: Re: [v2] powerpc/configs: Enable LEDS support
References: <20150827102619.BEB9214018C@ozlabs.org>
In-Reply-To: <20150827102619.BEB9214018C@ozlabs.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/27/2015 03:56 PM, Michael Ellerman wrote:
> On Thu, 2015-27-08 at 06:04:10 UTC, Vasant Hegde wrote:
>> Commit 84ad6e5c added LEDS support for PowerNV platform. Lets
>> update ppc64_defconfig to pick LEDS driver.
>>
>> PowerNV LEDS driver looks for "/ibm,opal/leds" node in device
>> tree and loads if this node exists. Hence added it as 'm'.
>>
>> Also note that powernv LEDS driver needs NEW_LEDS and LEDS_CLASS
>> as well. Hence added them to config file.
>>
>> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
>> Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
>> Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
>> ---
>> Changes in v2:
>>   - As suggested by Stewart updated patch description
>>
>> Michael,
>>   This is PowerNV specific config. Hence I've not updated pseries_defconfig.
>>   Let me know if you want me to update pseries_defconfig config as well.
> 
> I've added it to pseries_defconfig also, no need to resend.

Thanks!

-Vasant
