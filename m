Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E33411A01CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 16:04:24 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Thu, 9 Jul 2015 11:34:21 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 79444E005C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 11:38:05 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6963rt834078774
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jul 2015 11:33:55 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6963q1m020876
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jul 2015 11:33:53 +0530
Message-ID: <559E0EC3.4090702@linux.vnet.ibm.com>
Date: Thu, 09 Jul 2015 11:33:47 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/powernv: Fix race in updating core_idle_state
References: <1436213363-18419-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1436228558.3341.1.camel@ellerman.id.au>
 <1436416901.28537.11.camel@axtens.net>
In-Reply-To: <1436416901.28537.11.camel@axtens.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 07/09/2015 10:11 AM, Daniel Axtens wrote:
>> I recommend creating an alias or script that does:
>>
>> $ git log --pretty=fixes -n 1 $commit | xclip
>>
> 
> FWIW, having finally got around to doing this, I found I first needed
> the following snippet in ~/.gitconfig from
> https://www.kernel.org/doc/Documentation/SubmittingPatches
> 
> 
> 	[core]
> 		abbrev = 12
> 	[pretty]
> 		fixes = Fixes: %h (\"%s\")
> 
> Otherwise git doesn't know what the pretty format is.
>


Right, thanks for the pointer!

Thanks,
Shreyas
