Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSMCG1bDxzDqJ6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 00:43:21 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1LDXdO5106438
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 08:43:19 -0500
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28rku6ftjn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 08:43:19 -0500
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Tue, 21 Feb 2017 10:43:17 -0300
Received: from d24relay04.br.ibm.com (d24relay04.br.ibm.com [9.18.232.146])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 612D1352006C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 08:42:40 -0500 (EST)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1LDh5FG32571572
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 10:43:13 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1LDgg9G028735
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 10:42:42 -0300
Subject: Re: [PATCH 2/3] powerpc/xmon: drop the nobt option from xmon plus
 minor fixes
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <1487290677-7200-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1487290677-7200-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <87poicm8cw.fsf@concordia.ellerman.id.au>
 <87k28km7jz.fsf@concordia.ellerman.id.au>
Cc: paulus@samba.org, npiggin@gmail.com, xinhui.pan@linux.vnet.ibm.com
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Tue, 21 Feb 2017 10:42:16 -0300
MIME-Version: 1.0
In-Reply-To: <87k28km7jz.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Message-Id: <349279b4-3935-bb53-5807-d8a0a1b8a5c4@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/21/2017 02:33 AM, Michael Ellerman wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
>> "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:
> ...
>>
>> Imagine you're debugging a machine and you drop into xmon to check
>> something, then drop out again.
>>
>> Then you go away and leave the box, and it crashes into xmon, but xmon
>> doesn't print a backtrace because you've already been in xmon. Usually
>> you can just get on the console and hit 't', but sometimes the machine
>> crashes so hard that xmon doesn't take input - in which case you now
>> have no backtrace. :sadface:
> 
> OK I read your patch wrong, the above won't happen.
> 
> But I still don't think we need any of the auto back trace suppression.

Just to clarify, so do you think we always should print the backtrace
automatically, correctly? I can change it and resend the patch if you want.

Thanks,


Guilherme

> 
> cheers
> 
