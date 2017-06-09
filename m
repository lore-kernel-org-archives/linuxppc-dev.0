Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wknQc2JkGzDqP9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Jun 2017 02:13:28 +1000 (AEST)
Subject: Re: [PATCH v2 2/2] powerpc/mm/hugetlb: Add support for reserving
 gigantic huge pages via kernel command line
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Scott Wood <oss@buserror.net>
References: <1496327441-7368-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1496327441-7368-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <b785b7b4-d6ee-3884-c140-74499171518c@c-s.fr>
 <87bmq23mgz.fsf@skywalker.in.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <c989afa0-0f82-7317-89e2-c3f84219e538@c-s.fr>
Date: Fri, 9 Jun 2017 18:13:23 +0200
MIME-Version: 1.0
In-Reply-To: <87bmq23mgz.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 05/06/2017 à 09:47, Aneesh Kumar K.V a écrit :
> christophe leroy <christophe.leroy@c-s.fr> writes:
> 
>> Le 01/06/2017 à 16:30, Aneesh Kumar K.V a écrit :
>>> With commit aa888a74977a8 ("hugetlb: support larger than MAX_ORDER") we added
>>> support for allocating gigantic hugepages via kernel command line. Switch
>>> ppc64 arch specific code to use that.
>>
>> Is it only ppc64 ? Your patch removes things defined for the 8xx and
>> modifies stuff in init_32.c
>>
>> On the 8xx, as far as I remember, 8M pages on 4k pages mode are above
>> default MAX_ORDER, I solved it by increasing MAX_ORDER. Is that wrong ?
> 
> 
> I was hoping every platform can switch to generic code. Obviously I
> didn't test the changes on anything other than ppc64. Can you try with
> this patchset and pass hugepagesz=<size> hugepages=<number> kernel arg
> and see if hugepage allocation works for you ?
> 

I'm sorry I didn't have time to test it this week and I won't have time 
either in the next two weeks.

Christophe
