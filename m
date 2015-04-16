Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3BD0F1A0021
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 15:08:07 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Thu, 16 Apr 2015 15:08:05 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 296E93578048
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 15:08:02 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3G57rIu58589400
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 15:08:01 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3G57Swc020694
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 15:07:28 +1000
Message-ID: <552F437E.4020409@linux.vnet.ibm.com>
Date: Thu, 16 Apr 2015 10:37:10 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH v2 2/2] leds/powernv: Add driver for PowerNV platform
References: <20150320105921.14866.83209.stgit@localhost.localdomain>
 <20150320110328.14866.98225.stgit@localhost.localdomain>
 <552D303A.5080506@samsung.com> <m3zj69ql8x.fsf@oc8180480414.ibm.com>
In-Reply-To: <m3zj69ql8x.fsf@oc8180480414.ibm.com>
Content-Type: text/plain; charset=windows-1252
Cc: cooloney@gmail.com, rpurdie@rpsys.net, linuxppc-dev@lists.ozlabs.org,
 linux-leds@vger.kernel.org, khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/16/2015 12:20 AM, Stewart Smith wrote:
> Jacek Anaszewski <j.anaszewski@samsung.com> writes:
>>> +static struct platform_driver powernv_led_driver = {
>>> +	.probe	= powernv_led_probe,
>>> +	.remove = powernv_led_remove,
>>> +	.driver = {
>>> +		.name = "powernv-led-driver",
>>> +		.owner = THIS_MODULE,
>>> +		.of_match_table = powernv_led_match,
>>
>> Is somewhere DT documentation available for these leds?
> 
> https://github.com/open-power/skiboot/blob/master/doc/device-tree/ibm%2Copal/led.txt
> 
> We've been documenting things in firmware source, and I'm open to if we
> should mirror this somewhere (somewhere in linux Documentation/ ?).

Stewart,

I'm adding Documentation/devicetree/bindings/leds/leds-powernv.txt ...which is
pretty much similar to the device tree documentation we have in OPAL side.

> 
> If we duplicate everything, we shouldn't let things get out of date.

-Vasant
