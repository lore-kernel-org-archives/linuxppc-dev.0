Return-Path: <vrbagal1@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xQFk43rKzDr30
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 21:28:42 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4VBOARg062814
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 07:28:40 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jaf24jtxf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 07:28:39 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vrbagal1@linux.vnet.ibm.com>;
 Thu, 31 May 2018 07:28:38 -0400
Subject: Re: Build Failure on linux-next on Power8 machine
To: Christophe LEROY <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org
Cc: sfr@canb.auug.org.au
References: <d377489b3333eca0951510c19b7d8878@linux.vnet.ibm.com>
 <5abede57-06bd-bb3c-385e-11a61a380027@c-s.fr>
From: Venkat Rao B <vrbagal1@linux.vnet.ibm.com>
Date: Thu, 31 May 2018 16:58:34 +0530
MIME-Version: 1.0
In-Reply-To: <5abede57-06bd-bb3c-385e-11a61a380027@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1fd71673-9e1e-9f95-057e-ed8fb87e503d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 31 May 2018 04:44 PM, Christophe LEROY wrote:
> 
> 
> Le 31/05/2018 à 12:38, vrbagal1 a écrit :
>> Greetings!!!
>>
>>
>> I am observing a build failure on linux-next kernel.
>>
>> Machine: Power8
>> Platform: PowerNV(Baremetal)
>> Git Tree: 
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> 
> Which defconfig do you use, or can you give your .config ?
> 
> Christophe
> 
> 
Unfortunately I lost it. I  only have complete fail logs. Will that be 
helpful?

Venkat
>>
>> Below is the build error.
>>
>> 14:20:48 make[1]: *** [kernel/umh.o] Error 1
>> 14:20:48 make[1]: *** [kernel/fork.o] Error 1
>> 14:20:48 In file included from ./arch/powerpc/include/asm/highmem.h:30:0,
>> 14:20:48                  from ./include/linux/highmem.h:35,
>> 14:20:48                  from ./include/linux/pagemap.h:11,
>> 14:20:48                  from security/commoncap.c:19:
>> 14:20:48 ./arch/powerpc/include/asm/fixmap.h:52:2: error: overflow in 
>> enumeration values
>> 14:20:48   FIX_KMAP_BEGIN, /* reserved pte's for temporary kernel 
>> mappings */
>> 14:20:48   ^
>> 14:20:48 make[2]: *** [kernel/sched/swait.o] Error 1
>> 14:20:48 make[1]: *** [mm/page_alloc.o] Error 1
>> 14:20:48 make[1]: *** [kernel/sched] Error 2
>> 14:20:48 make: *** [mm] Error 2
>> 14:20:48 make[1]: *** [kernel/exit.o] Error 1
>> 14:20:48 make[1]: *** [security/commoncap.o] Error 1
>> 14:20:48 make[1]: *** [fs/kernfs] Error 2
>> 14:20:48 make: *** [fs] Error 2
>> 14:20:48 make: *** [arch/powerpc/kernel] Error 2
>> 14:20:48 make: *** [security] Error 2
>> 14:20:48 make: *** [kernel] Error 2
>>
>> Cheers.
> 
