Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4E80D1A0BBD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 05:01:34 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 15 Apr 2015 15:01:32 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id DD3A4C90057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 14:47:37 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3FIuSbf37355688
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 18:56:28 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3FIuSEv029931
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 14:56:28 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Jacek Anaszewski <j.anaszewski@samsung.com>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] leds/powernv: Add driver for PowerNV platform
In-Reply-To: <552D303A.5080506@samsung.com>
References: <20150320105921.14866.83209.stgit@localhost.localdomain>
 <20150320110328.14866.98225.stgit@localhost.localdomain>
 <552D303A.5080506@samsung.com>
Date: Wed, 15 Apr 2015 11:50:22 -0700
Message-ID: <m3zj69ql8x.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Jacek Anaszewski <j.anaszewski@samsung.com> writes:
>> +static struct platform_driver powernv_led_driver = {
>> +	.probe	= powernv_led_probe,
>> +	.remove = powernv_led_remove,
>> +	.driver = {
>> +		.name = "powernv-led-driver",
>> +		.owner = THIS_MODULE,
>> +		.of_match_table = powernv_led_match,
>
> Is somewhere DT documentation available for these leds?

https://github.com/open-power/skiboot/blob/master/doc/device-tree/ibm%2Copal/led.txt

We've been documenting things in firmware source, and I'm open to if we
should mirror this somewhere (somewhere in linux Documentation/ ?).

If we duplicate everything, we shouldn't let things get out of date.

FWIW I won't merge code that changes device tree that skiboot emits
without associated documentation.
