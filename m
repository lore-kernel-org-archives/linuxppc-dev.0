Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D2AD1A0245
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 09:03:45 +1000 (AEST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 21 Apr 2015 19:03:41 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 8CD8738C8041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 19:03:39 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3LN3dkH58392582
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 23:03:39 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3LN3cNm027265
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 19:03:39 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Subject: Re: [PATCH v2 2/2] leds/powernv: Add driver for PowerNV platform
In-Reply-To: <552F437E.4020409@linux.vnet.ibm.com>
References: <20150320105921.14866.83209.stgit@localhost.localdomain>
 <20150320110328.14866.98225.stgit@localhost.localdomain>
 <552D303A.5080506@samsung.com> <m3zj69ql8x.fsf@oc8180480414.ibm.com>
 <552F437E.4020409@linux.vnet.ibm.com>
Date: Wed, 22 Apr 2015 09:03:36 +1000
Message-ID: <m3sibtozhz.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: cooloney@gmail.com, Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 rpurdie@rpsys.net, linuxppc-dev@lists.ozlabs.org,
 Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org,
 khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vasant Hegde <hegdevasant@linux.vnet.ibm.com> writes:
> On 04/16/2015 12:20 AM, Stewart Smith wrote:
>> Jacek Anaszewski <j.anaszewski@samsung.com> writes:
>>>> +static struct platform_driver powernv_led_driver = {
>>>> +	.probe	= powernv_led_probe,
>>>> +	.remove = powernv_led_remove,
>>>> +	.driver = {
>>>> +		.name = "powernv-led-driver",
>>>> +		.owner = THIS_MODULE,
>>>> +		.of_match_table = powernv_led_match,
>>>
>>> Is somewhere DT documentation available for these leds?
>> 
>> https://github.com/open-power/skiboot/blob/master/doc/device-tree/ibm%2Copal/led.txt
>> 
>> We've been documenting things in firmware source, and I'm open to if we
>> should mirror this somewhere (somewhere in linux Documentation/ ?).
>
> Stewart,
>
> I'm adding Documentation/devicetree/bindings/leds/leds-powernv.txt ...which is
> pretty much similar to the device tree documentation we have in OPAL side.

Michael,

I know we've kind of discussed this in the past, but perhaps we should
come up with a conistent way of doing this for OPAL related docs.
