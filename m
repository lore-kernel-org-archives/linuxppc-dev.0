Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqD7c3VJ1zDqH1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 19:29:48 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6D9SwAd025760
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:29:45 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24567cnnjg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:29:45 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Wed, 13 Jul 2016 03:29:43 -0600
Subject: Re: [PATCH v3 3/4] perf annotate: add powerpc support
To: Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
References: <1467267262-4589-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1467267262-4589-4-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1467267714.7296.6.camel@ellerman.id.au>
 <57762D2A.9040103@linux.vnet.ibm.com>
 <87vb0j84fb.fsf@@concordia.ellerman.id.au>
 <577F31D9.4050808@linux.vnet.ibm.com>
 <87zipsmsyd.fsf@@concordia.ellerman.id.au>
 <5784543A.9030801@linux.vnet.ibm.com> <20160712023937.GC3387@kernel.org>
 <87eg6ym1gq.fsf@@concordia.ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 anton@ozlabs.org, ananth@in.ibm.com, dja@axtens.net,
 naveen.n.rao@linux.vnet.ibm.com, David.Laight@ACULAB.COM,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Wed, 13 Jul 2016 14:59:23 +0530
MIME-Version: 1.0
In-Reply-To: <87eg6ym1gq.fsf@@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <578609F3.5090707@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 13 July 2016 01:09 PM, Michael Ellerman wrote:
> Arnaldo Carvalho de Melo <acme@kernel.org> writes:
>
>> Em Tue, Jul 12, 2016 at 07:51:46AM +0530, Ravi Bangoria escreveu:
>>> Hi Arnaldo,
>>>
>>> On Friday 08 July 2016 02:01 PM, Michael Ellerman wrote:
>>>> Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> writes:
>>>>
>>>>> On Wednesday 06 July 2016 03:38 PM, Michael Ellerman wrote:
>>>>>
>>>>> I've sent v4 which enables annotate for bctr' instructions.
>>>>>
>>>>> for 'bctr', it will show down arrow(indicate jump) and 'bctrl' will show
>>>>> right arrow(indicate call). But no navigation options will be provided.
>>>>> By pressing Enter key on that, message will be shown that like
>>>>> "Invalid target"
>>>> Great thanks.
>>> I've sent v4 series. Please review it.
>> If somebody else could do it and provide acks/reviewed by, that would
>> help,
>>
>> Michael, can I get your comments as such?
> It looks OK to me. But I don't know the code really, and I haven't had
> time to test it personally.
>
> Ravi, have you tested on a big endian machine?

Yes Michael, I've tested annotate on BE and LE both.

-Ravi

>
> cheers
>
