Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 519F52C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 12:51:29 +1100 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 5 Mar 2014 07:21:23 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 2EB66E0044
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 07:24:59 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s251pMSb1179964
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Mar 2014 07:21:22 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s251pJue028366
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Mar 2014 07:21:19 +0530
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] powerpc/powernv Platform dump interface
In-Reply-To: <5315C592.4050605@linux.vnet.ibm.com>
References: <1393393321-9902-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1393802742-3891-1-git-send-email-stewart@linux.vnet.ibm.com>
 <5315C592.4050605@linux.vnet.ibm.com>
Date: Wed, 05 Mar 2014 12:51:16 +1100
Message-ID: <871tyhl8ff.fsf@river.au.ibm.com>
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
>> +		Each dump has the following files:
>> +		id:		An ASCII representation of the dump ID
>> +				in hex (e.g. '0x01')
>> +		type:		An ASCII representation of the type of
>> +				dump in the format "0x%x %s" with the ID
>
> Better 0x%x - %s ?

I thought of that, but figured that a simple space is probably slightly
easier to parse programatically.
