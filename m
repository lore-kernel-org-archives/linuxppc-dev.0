Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9BEC22C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 15:05:54 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 5 Mar 2014 09:35:52 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 5C8BF1258053
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 09:37:59 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2545rDX2752828
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Mar 2014 09:35:53 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2545nEI030864
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Mar 2014 09:35:49 +0530
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Read OPAL error log and export it
 through sysfs
In-Reply-To: <1393992008.11372.1.camel@pasglop>
References: <87k3cin5kd.fsf@river.au.ibm.com>
 <1393549112-6101-1-git-send-email-stewart@linux.vnet.ibm.com>
 <5315C7B6.1030602@linux.vnet.ibm.com> <87vbvtjtmh.fsf@river.au.ibm.com>
 <53169971.8050607@linux.vnet.ibm.com> <1393992008.11372.1.camel@pasglop>
Date: Wed, 05 Mar 2014 15:05:46 +1100
Message-ID: <87mwh5jnmt.fsf@river.au.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> On Wed, 2014-03-05 at 08:56 +0530, Vasant Hegde wrote:
>> On 03/05/2014 07:26 AM, Stewart Smith wrote:
>> > Vasant Hegde <hegdevasant@linux.vnet.ibm.com> writes:
>> >>> +int64_t opal_send_ack_elog(uint64_t log_id);
>> >>
>> >> Stewart,
>> >>
>> >> Why are you creating 64bit log ID  when actual ID is 32bit ?
>> >
>> > IIRC it's what OPAL gives us, even though FSP MBOX spec says 32bit.
>> >
>> 
>> Stewart,
>> 
>> Better ask OPAL folks to fix in firmware ?
>
> Why bother ? That way if future versions of OPAL want to use 64-bit IDs,
> they can.

Yeah, that was my thought. The number of error logs on some POWER8
systems almost needs 64bit already :)
