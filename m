Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 63E072C01A7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 12:56:32 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 5 Mar 2014 11:56:28 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DDDC32CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 12:56:24 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s251uAQW10682760
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Mar 2014 12:56:11 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s251uOtb007179
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Mar 2014 12:56:24 +1100
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: Read OPAL error log and export it
 through sysfs
In-Reply-To: <5315C7B6.1030602@linux.vnet.ibm.com>
References: <87k3cin5kd.fsf@river.au.ibm.com>
 <1393549112-6101-1-git-send-email-stewart@linux.vnet.ibm.com>
 <5315C7B6.1030602@linux.vnet.ibm.com>
Date: Wed, 05 Mar 2014 12:56:22 +1100
Message-ID: <87vbvtjtmh.fsf@river.au.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vasant Hegde <hegdevasant@linux.vnet.ibm.com> writes:
>> +int64_t opal_send_ack_elog(uint64_t log_id);
>
> Stewart,
>
> Why are you creating 64bit log ID  when actual ID is 32bit ?

IIRC it's what OPAL gives us, even though FSP MBOX spec says 32bit.
