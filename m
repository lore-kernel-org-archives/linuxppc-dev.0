Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xrJ0H3BXfzDrnS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Sep 2017 16:28:31 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8B6O2Sx051718
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Sep 2017 02:28:27 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cw7cnmetg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Sep 2017 02:28:27 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 11 Sep 2017 07:28:25 +0100
Subject: Re: [PATCH v2 00/20] Speculative page faults
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
 mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
References: <1503007519-26777-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <20170821022629.GA541@jagdpanzerIV.localdomain>
 <6302a906-221d-c977-4aea-67202eb3d96d@linux.vnet.ibm.com>
 <20170911004523.GA2938@jagdpanzerIV.localdomain>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Mon, 11 Sep 2017 08:28:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170911004523.GA2938@jagdpanzerIV.localdomain>
Content-Type: text/plain; charset=utf-8
Message-Id: <da0e23a5-f2b9-bd84-8f62-0a84d1194bd7@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/09/2017 02:45, Sergey Senozhatsky wrote:
> On (09/08/17 11:24), Laurent Dufour wrote:
>> Hi Sergey,
>>
>> I can't see where such a chain could happen.
>>
>> I tried to recreate it on top of the latest mm tree, to latest stack output
>> but I can't get it.
>> How did you raised this one ?
> 
> Hi Laurent,
> 
> didn't do anything special, the box even wasn't under severe memory
> pressure. can re-test your new patch set.

Hi Sergey,

I sent a v3 series, would you please give it a try ?

Thanks,
Laurent.
