Return-Path: <srs0=eiuy=52=linux.vnet.ibm.com=mauricfo@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wt7xh3gsfzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 01:32:24 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wt7xh18tpz8sy4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 01:32:24 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wt7xg4NYcz9s74
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2017 01:32:23 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5LFTfds129534
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Jun 2017 11:32:20 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b7tfdujuy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Jun 2017 11:32:20 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Wed, 21 Jun 2017 12:32:18 -0300
Subject: Re: 1M hugepage size being registered on Linux
To: jk@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 victora <victora@linux.vnet.ibm.com>, alistair@popple.id.au,
 victora@br.ibm.com, linuxppc-dev@ozlabs.org
References: <322aa4a1a11ca79008a8c894c12a80d5@linux.vnet.ibm.com>
 <87wp85sk9o.fsf@concordia.ellerman.id.au>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Wed, 21 Jun 2017 12:32:11 -0300
MIME-Version: 1.0
In-Reply-To: <87wp85sk9o.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <3493fb6b-5212-843c-60b8-b2b715b52154@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/21/2017 07:33 AM, Michael Ellerman wrote:
>> I am working on a bug related to 1M hugepage size being registered on
>> Linux (Power 8 Baremetal - Garrison).

> Wasn't that caused by a firmware bug?

Ben/Stewart, does that ring a bell, something new, intended or not? :- )

Thanks,

>> I was checking dmesg and it seems that 1M page size is coming from
>> firmware to Linux.
>>
>> [    0.000000] base_shift=20: shift=20, sllp=0x0130, avpnm=0x00000000,
>> tlbiel=0, penc=2
>> [    1.528867] HugeTLB registered 1 MB page size, pre-allocated 0 pages
>>
>> Should Linux support this page size?
> Does it work?:)
> 
> The user manual says it's a supported size, but I thought it didn't work
> (in hardware) for some reason.

-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
