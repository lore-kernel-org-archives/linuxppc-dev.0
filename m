Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4D6A82C023F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 14:26:40 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Wed, 5 Mar 2014 08:56:37 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 79DCA1258056
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 08:58:44 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s253QUso1900872
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Mar 2014 08:56:30 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s253QYJ7005619
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Mar 2014 08:56:34 +0530
Message-ID: <53169969.7040403@linux.vnet.ibm.com>
Date: Wed, 05 Mar 2014 08:56:33 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: Read OPAL error log and export it through
 sysfs
References: <87k3cin5kd.fsf@river.au.ibm.com>
 <1393549112-6101-1-git-send-email-stewart@linux.vnet.ibm.com>
 <5315C7B6.1030602@linux.vnet.ibm.com> <87vbvtjtmh.fsf@river.au.ibm.com>
In-Reply-To: <87vbvtjtmh.fsf@river.au.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/05/2014 07:26 AM, Stewart Smith wrote:
> Vasant Hegde <hegdevasant@linux.vnet.ibm.com> writes:
>>> +int64_t opal_send_ack_elog(uint64_t log_id);
>>
>> Stewart,
>>
>> Why are you creating 64bit log ID  when actual ID is 32bit ?
>
> IIRC it's what OPAL gives us, even though FSP MBOX spec says 32bit.
>

Stewart,

Better ask OPAL folks to fix in firmware ?

-Vasant
