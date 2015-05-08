Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1193D1A113B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 16:19:49 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Fri, 8 May 2015 11:49:47 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 11855E004C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 11:52:38 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t486GwQC36175952
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 May 2015 11:49:43 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t486GqxO010307
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 May 2015 11:46:53 +0530
Message-ID: <554C54D1.9060301@linux.vnet.ibm.com>
Date: Fri, 08 May 2015 11:46:49 +0530
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 1/2] perf/kvm: Port perf kvm to powerpc
References: <1431047266-6206-1-git-send-email-hemant@linux.vnet.ibm.com>
 <20150508042853.GA24391@gmail.com>
In-Reply-To: <20150508042853.GA24391@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: maddy@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com, peterz@infradead.org,
 agraf@suse.de, kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 mingo@redhat.com, paulus@samba.org, acme@kernel.org,
 warrier@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 05/08/2015 09:58 AM, Ingo Molnar wrote:
> * Hemant Kumar <hemant@linux.vnet.ibm.com> wrote:
>
>>   # perf kvm stat report -p 60515
>> Analyze events for pid(s) 60515, all VCPUs:
>>
>>         VM-EXIT    Samples  Samples%     Time%    Min Time         Max        Time         Avg time
>>
>> H_DATA_STORAGE       5006    35.30%     0.13%      1.94us     49.46us     12.37us ( +-   0.52% )
>> HV_DECREMENTER       4457    31.43%     0.02%      0.72us     16.14us      1.91us ( +-   0.96% )
>>         SYSCALL       2690    18.97%     0.10%      2.84us    528.24us     18.29us ( +-   3.75% )
>> RETURN_TO_HOST       1789    12.61%    99.76%      1.58us 672791.91us  27470.23us ( +-   3.00% )
>>        EXTERNAL        240     1.69%     0.00%        0.69us     10.67us      1.33us ( +-   5.34% )
> Where is the last line misaligned? Copy & paste error or does perf kvm
> produce it in such a way?

Its a copy-paste error. Thanks for pointing this out.

Shall I resend the patches with the correct alignment of the o/p?

> Thanks,
>
> 	Ingo
>

-- 
Thanks,
Hemant Kumar
