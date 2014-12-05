Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 088591A0BD2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 16:15:27 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B5AEC1400E9
 for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2014 16:15:26 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 5 Dec 2014 15:15:25 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6B6AD2BB005B
 for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2014 16:15:23 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB55FFAf38797394
 for <linuxppc-dev@ozlabs.org>; Fri, 5 Dec 2014 16:15:16 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB55FMpS015317
 for <linuxppc-dev@ozlabs.org>; Fri, 5 Dec 2014 16:15:22 +1100
Message-ID: <54813F5E.601@linux.vnet.ibm.com>
Date: Fri, 05 Dec 2014 10:45:10 +0530
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [2/2] pstore: add pstore support on powernv
References: <20141204053708.E24341400EA@ozlabs.org>
In-Reply-To: <20141204053708.E24341400EA@ozlabs.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/04/2014 11:07 AM, Michael Ellerman wrote:
> On Wed, 2014-03-12 at 11:03:15 UTC, Hari Bathini wrote:
>> This patch extends pstore, a generic interface to platform dependent
>> persistent storage, support for powernv  platform to capture certain
>> useful information, during dying moments. Such support is already in
>> place for  pseries platform.  This patch while adding pstore support
>> for  powernv platform,  moves common code for pseries and powernv to
>> arch/powerpc/kernel/nvram_64.c file.
> Please move the common code first in a separate patch. Unless there's some
> reason you absolutely can't do that.

Sure, Michael. Let me make the changes as suggested and
post the updated patch series.

Thanks
Hari

> cheers
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
