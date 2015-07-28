Return-Path: <jacek.anaszewski@gmail.com>
Received: from mail-wi0-x233.google.com (mail-wi0-x233.google.com
 [IPv6:2a00:1450:400c:c05::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 798891A06A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 21:25:17 +1000 (AEST)
Received: by wicmv11 with SMTP id mv11so175145380wic.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 04:25:14 -0700 (PDT)
Message-ID: <55B76634.6050505@gmail.com>
Date: Tue, 28 Jul 2015 13:23:32 +0200
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
CC: linux-leds@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 j.anaszewski@samsung.com, mpe@ellerman.id.au, rpurdie@rpsys.net,
 cooloney@gmail.com, khandual@linux.vnet.ibm.com,
 j.anaszewski81@gmail.com, arnd@arndb.de, stewart@linux.vnet.ibm.com
Subject: Re: [PATCH v8 3/3] leds/powernv: Add driver for PowerNV platform
References: <1437801670-23705-1-git-send-email-hegdevasant@linux.vnet.ibm.com>	
 <1437801670-23705-4-git-send-email-hegdevasant@linux.vnet.ibm.com>	
 <55B5540B.1000301@gmail.com> <55B5A853.3080909@linux.vnet.ibm.com>	
 <55B72369.5040102@gmail.com> <1438078495.7562.135.camel@kernel.crashing.org>
In-Reply-To: <1438078495.7562.135.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 28.07.2015 12:14, Benjamin Herrenschmidt wrote:
> On Tue, 2015-07-28 at 08:38 +0200, Jacek Anaszewski wrote:
>>>>> +    /* Register the classdev */
>>>>> +    rc = devm_led_classdev_register(dev, &powernv_led->cdev);
>>>>> +    if (rc) {
>>>>> +        dev_err(dev, "%s: Classdev registration failed for %s\n",
>>>>> +            __func__, powernv_led->cdev.name);
>>>>> +    }
>>
>> Braces are not needed here,
>
> Putting my old maintainer hat on for a minute ... this is serious nit
> picking :-)
>
> Arguably, the function being multi-line, the braces do make the code
> more readable. This is a matter of taste which in such as case
> which isn't a blatant violation of an important rule should be left to
> the choice of the code implementor/maintainer.

I will not insist as checkpatch.pl also doesn't complain
about that.

Vasant, please ignore my remark then.

-- 
Best Regards,
Jacek Anaszewski
