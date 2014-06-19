Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 068AD1A0327
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 15:33:29 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Thu, 19 Jun 2014 11:03:25 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 2936AE0044
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 11:04:30 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5J5Xb8863635488
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 11:03:37 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5J5XMLk023971
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 11:03:22 +0530
Message-ID: <53A27620.9040309@linux.vnet.ibm.com>
Date: Thu, 19 Jun 2014 13:33:20 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Boot failure in Power7 pSeries
References: <53A00E2B.8030903@linux.vnet.ibm.com>
 <53A1070C.50106@linux.vnet.ibm.com> <1403078080.32307.6.camel@concordia>
 <53A155A6.2030805@linux.vnet.ibm.com> <1403141538.4768.2.camel@concordia>
 <53A2488A.1060507@linux.vnet.ibm.com> <1403150108.4768.3.camel@concordia>
In-Reply-To: <1403150108.4768.3.camel@concordia>
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

On 06/19/2014 11:55 AM, Michael Ellerman wrote:
> On Thu, 2014-06-19 at 10:18 +0800, Mike Qiu wrote:
>> On 06/19/2014 09:32 AM, Michael Ellerman wrote:
>>> On Wed, 2014-06-18 at 17:02 +0800, Mike Qiu wrote:
>>>> On 06/18/2014 03:54 PM, Michael Ellerman wrote:
>>>>> On Wed, 2014-06-18 at 11:27 +0800, Mike Qiu wrote:
>>>>>> Anyone has a idea on this issue?
>>>>> Did it ever work? If so which kernel version?
>>>> It works for 3.15, but failed with linux version 3.16.0-rc1-next-20140617
>>> What about 3.16-rc1 ?
>> 3.16-rc1 still not work. the same issue.
>>
>>>> The config file can be simply get from /boot/configxxx. and "make
>>>> menuconfig" and save without change anything(default).
>>> Sure, but I don't have access to your box so please ..
>>    * OS address 9.3.110.192 root/linux123
>>    * Minicom server: 9.3.191.26 root/linux123
>>        o minicom -D /dev/ttyS0
>>
>>           fsp: http://cena-fsp.austin.ibm.com
> Please change that password immediately, and don't EVER post the login details
> for a machine on a public list again.
>
> Also I'm not offering to logon to your machine and debug it, I'm giving you
> advice on how you can debug it.

...OK, got it, my mistake...

Thanks
Mike
>
> cheers
>
>
>
