Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE5D31A0091
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 12:20:08 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Thu, 19 Jun 2014 12:20:08 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 377992CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 12:20:06 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5J23pxt31719674
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 12:03:51 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5J2K5fY028851
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 12:20:05 +1000
Message-ID: <53A248D3.60109@linux.vnet.ibm.com>
Date: Thu, 19 Jun 2014 10:20:03 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Boot failure in Power7 pSeries
References: <53A00E2B.8030903@linux.vnet.ibm.com>
 <53A1070C.50106@linux.vnet.ibm.com> <1403078080.32307.6.camel@concordia>
 <53A155A6.2030805@linux.vnet.ibm.com> <1403141538.4768.2.camel@concordia>
In-Reply-To: <1403141538.4768.2.camel@concordia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/19/2014 09:32 AM, Michael Ellerman wrote:
> On Wed, 2014-06-18 at 17:02 +0800, Mike Qiu wrote:
>> On 06/18/2014 03:54 PM, Michael Ellerman wrote:
>>> On Wed, 2014-06-18 at 11:27 +0800, Mike Qiu wrote:
>>>> Anyone has a idea on this issue?
>>> Did it ever work? If so which kernel version?
>> It works for 3.15, but failed with linux version 3.16.0-rc1-next-20140617
> What about 3.16-rc1 ?
>
>> The config file can be simply get from /boot/configxxx. and "make
>> menuconfig" and save without change anything(default).
> Sure, but I don't have access to your box so please ..
>
>>> Can you attach your actual .config.
>      ^^^^
>
>>> You could try building without CONFIG_PPC_POWERNV.
>> Trying...., but it should work as default config from /boot/
> Well yes that would be nice, but I'm trying to help you narrow down what the
> problem is.

When boot, pls select the "P3-D1" in the menu

Thanks
Mike
>
> cheers
>
>
>
