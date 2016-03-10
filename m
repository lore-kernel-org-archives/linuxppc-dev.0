Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 949CD1A02DE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Mar 2016 04:23:15 +1100 (AEDT)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F3115140216
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Mar 2016 04:23:14 +1100 (AEDT)
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Thu, 10 Mar 2016 22:53:12 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2AHMrM09503048
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 22:52:53 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2AMq6E4029227
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Mar 2016 04:22:06 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>, Ian Munsie <imunsie@au1.ibm.com>,
 Michael Ellerman <michaele@au1.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Matt Ochs <mrochs@us.ibm.com>, Manoj Kumar <kumarmn@us.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH v3 1/2] cxl: Add mechanism for delivering AFU driver
 specific events
In-Reply-To: <1457580271.26279.8.camel@neuling.org>
References: <1457401715-26435-1-git-send-email-imunsie@au.ibm.com>
 <87a8m7iunv.fsf@vajain21.in.ibm.com> <1457580271.26279.8.camel@neuling.org>
Date: Thu, 10 Mar 2016 22:53:06 +0530
Message-ID: <87fuvyp7r9.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> writes:

> These are here to enable the feature in other drivers.  So the cxlflash
> (or whoever) can put their code in via the linux-scsi tree but that new
> piece is only enabled when CXL_AFU_DRIVER_OPS is present (ie. when
> merged upstream).  But if it's not, their code can still compile.  
>
> Hence their code compiles in linux-scsi and our code compiles in linux
> -ppc, but only once they're together do they actually enable the full
> feature.  We don't have a nasty dependency of linux-scsi having to pull
> in linux-ppc or visa versa before the merge window.  Everyone works
> independently and it all gets fixed in linus tree.
>
> Eventually, when everyone has the all the code in merged upstream, we
> can remove these config options.  We should be able to remove
>  CXL_KERNEL_API and CXL_EEH now actually!
>
> So no, we shouldn't wrap the actual code.


Mikey & Ian,

Agree on the point made. Thanks for detailed explaination.

~ Vaibhav
