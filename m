Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x231.google.com (mail-pf0-x231.google.com
 [IPv6:2607:f8b0:400e:c00::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvCdc5z4WzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 16:20:52 +1000 (AEST)
Received: by mail-pf0-x231.google.com with SMTP id 206so2881466pfu.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 23:20:52 -0700 (PDT)
Subject: Re: [PATCH V2 55/68] powerpc/mm: VMALLOC abstraction
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-56-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1461307925.32306.46.camel@neuling.org> <87h9etypdu.fsf@skywalker.in.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <571F08BB.5010906@gmail.com>
Date: Tue, 26 Apr 2016 16:20:43 +1000
MIME-Version: 1.0
In-Reply-To: <87h9etypdu.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 23/04/16 13:29, Aneesh Kumar K.V wrote:
> Michael Neuling <mikey@neuling.org> writes:
> 
>> Aneesh,
>>
>> I'm not sure why we need this patch.
>>
>> It seems to be moving the initialisation of some global variables into
>> init functions from the definitions.  And renames some things.
> 
> 
> because the value to which it is getting initialized is no more a
> constant.
> 

Isn't it still a constant depending on the type of page table? Or is it a run time value depending on the chosen page table type?

Balbir Singh
