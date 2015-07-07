Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E14E51A0D84
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2015 11:17:40 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Tue, 7 Jul 2015 06:47:37 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 5AF3D125804F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2015 06:50:24 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t671HXbL1507686
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Jul 2015 06:47:34 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t671HWUk000928
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Jul 2015 06:47:33 +0530
Message-ID: <559B28AC.2070103@linux.vnet.ibm.com>
Date: Tue, 07 Jul 2015 06:47:32 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
CC: Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/powernv: Fix race in updating core_idle_state
References: <1436213363-18419-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1436228558.3341.1.camel@ellerman.id.au>
In-Reply-To: <1436228558.3341.1.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 07/07/2015 05:52 AM, Michael Ellerman wrote:
> On Tue, 2015-07-07 at 01:39 +0530, Shreyas B. Prabhu wrote:
>> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
>> Fixes: 7b54e9f213f76 'powernv/powerpc: Add winkle support for offline
>> cpus'
> 
> The sha is wrong, it should be 77b54e9f213f.
> 
Argh! Sorry
> Also please don't wrap the description.
> 
> I recommend creating an alias or script that does:
> 
> $ git log --pretty=fixes -n 1 $commit | xclip
> 
Will use this from next time.
> 
> I've fixed it up, no need to resend.
> 

Thanks!

--Shreyas
