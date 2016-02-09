Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F7FA1A0191
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 02:21:27 +1100 (AEDT)
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 9 Feb 2016 15:21:24 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 729CE1B0805F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 15:21:35 +0000 (GMT)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u19FLMer5374168
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Feb 2016 15:21:22 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u19FLKam031698
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Feb 2016 08:21:21 -0700
Subject: Re: [PATCH v3 13/18] cxl: sysfs support for guests
To: Stewart Smith <stewart@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 michael.neuling@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
References: <1454765345-7417-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1454765345-7417-14-git-send-email-fbarrat@linux.vnet.ibm.com>
 <877fifykej.fsf@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-ID: <56BA03EF.8040507@linux.vnet.ibm.com>
Date: Tue, 9 Feb 2016 16:21:19 +0100
MIME-Version: 1.0
In-Reply-To: <877fifykej.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 08/02/2016 04:02, Stewart Smith a écrit :
> Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:
>> --- a/Documentation/ABI/testing/sysfs-class-cxl
>> +++ b/Documentation/ABI/testing/sysfs-class-cxl
>> @@ -183,7 +183,7 @@ Description:    read only
>>                   Identifies the revision level of the PSL.
>>   Users:		https://github.com/ibm-capi/libcxl
>>
>> -What:           /sys/class/cxl/<card>/base_image
>> +What:           /sys/class/cxl/<card>/base_image (not in a guest)
>
> Is this going to be the case for KVM guest as well as PowerVM guest?


That's too early to say.
The entries we've removed are because the information is filtered by 
pHyp and not available to the OS. Some of it because nobody thought it 
would be useful, some of it because it's not meant to be seen by the OS. 
For KVM, if the card can be shared between guests, I would expect the 
same kind of restrictions.

   Fred
