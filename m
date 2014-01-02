Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 287762C00A1
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Jan 2014 16:06:16 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 2 Jan 2014 10:36:14 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id EB08B1258054
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Jan 2014 10:37:37 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s02569YE46399502
 for <linuxppc-dev@ozlabs.org>; Thu, 2 Jan 2014 10:36:10 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0256BpH016307
 for <linuxppc-dev@ozlabs.org>; Thu, 2 Jan 2014 10:36:12 +0530
Message-ID: <52C4F37F.7040804@linux.vnet.ibm.com>
Date: Thu, 02 Jan 2014 10:35:03 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/2] power7, perf: Make some new raw event codes available
 in sysfs
References: <1381902780-2719-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1381902780-2719-2-git-send-email-khandual@linux.vnet.ibm.com>
 <1386903031.3853.2.camel@concordia> <52AA8D4C.6040905@linux.vnet.ibm.com>
 <1387331962.19507.4.camel@concordia>
In-Reply-To: <1387331962.19507.4.camel@concordia>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/18/2013 07:29 AM, Michael Ellerman wrote:
> On Fri, 2013-12-13 at 10:00 +0530, Anshuman Khandual wrote:
>> On 12/13/2013 08:20 AM, Michael Ellerman wrote:
>>> On Wed, 2013-10-16 at 11:22 +0530, Anshuman Khandual wrote:
>>>> This patch adds some more raw event codes into the existing list
>>>> of event codes present in power7-events-list.h file. This tries
>>>> to complete the list of events supported in Power7 and matches
>>>> the raw event list with libpfm4 library.
>>>
>>> It's a bit annoying, but you also need to update the "ABI" document:
>>
>> What is annoying ? you need to be specific.
> 
> It's annoying that we have to update the ABI document.
> 
>>>   Documentation/ABI/testing/sysfs-bus-event_source-devices-events
>>>
>>
>> The events listed under the following heading are events required to do
>> CPI analysis.
> 
> No they are not, it doesn't say that anywhere in the file.
> 
> It happens that the events in there *now* are the CPI events, but that's because
> they are the only ones that have been added.
> 
>> "Description:    POWER-systems specific performance monitoring event"
>>
>> 		  /sys/devices/cpu/events/PM_1PLUS_PPC_CMPL
>>                 /sys/devices/cpu/events/PM_BRU_FIN
>>                 /sys/devices/cpu/events/PM_BR_MPRED
>>                 /sys/devices/cpu/events/PM_CMPLU_STALL
> 
> All events that appear in /sys/devices/cpu/events on powerpc should be listed
> in the file.

Done, sent out the V2 version of the patch for POWER7 adding all the sysfs exported
raw events into the ABI documentation file.
