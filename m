Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D08341A0054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 12:18:57 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Thu, 19 Jun 2014 12:18:56 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3F4A62CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 12:18:53 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5J2Ia046816156
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 12:18:37 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5J2IqYK026469
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 12:18:52 +1000
Message-ID: <53A2488A.1060507@linux.vnet.ibm.com>
Date: Thu, 19 Jun 2014 10:18:50 +0800
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

3.16-rc1 still not work. the same issue.

>> The config file can be simply get from /boot/configxxx. and "make
>> menuconfig" and save without change anything(default).
> Sure, but I don't have access to your box so please ..

  * OS address 9.3.110.192 root/linux123
  * Minicom server: 9.3.191.26 root/linux123
      o minicom -D /dev/ttyS0

         fsp: http://cena-fsp.austin.ibm.com


>
>>> Can you attach your actual .config.
>      ^^^^
>
>>> You could try building without CONFIG_PPC_POWERNV.
>> Trying...., but it should work as default config from /boot/
> Well yes that would be nice, but I'm trying to help you narrow down what the
> problem is.

Great thanks

Mike
> cheers
>
>
>
