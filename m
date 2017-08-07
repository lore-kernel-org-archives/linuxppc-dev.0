Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xR0wP5tQMzDqnQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 00:56:21 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v77EssRL058377
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Aug 2017 10:56:19 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c6rw2vhpf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Aug 2017 10:56:18 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 7 Aug 2017 08:56:18 -0600
Date: Mon, 7 Aug 2017 20:26:09 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 1/2] powernv/powerpc:Save/Restore additional SPRs for
 stop4 cpuidle
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1500631040.git.ego@linux.vnet.ibm.com>
 <57ed82bcd92cd4d0af7ae5113710d597a331c433.1500631040.git.ego@linux.vnet.ibm.com>
 <87r2wvsgj1.fsf@concordia.ellerman.id.au>
 <20170807052331.GA30140@in.ibm.com>
 <87bmnrpyuz.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87bmnrpyuz.fsf@concordia.ellerman.id.au>
Message-Id: <20170807145609.GA31378@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mon, Aug 07, 2017 at 06:26:44PM +1000, Michael Ellerman wrote:
> Gautham R Shenoy <ego@linux.vnet.ibm.com> writes:
> > On Tue, Aug 01, 2017 at 08:56:18PM +1000, Michael Ellerman wrote:
> >> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
> >> >
> >> > Subject: [v3 PATCH 1/2] powernv/powerpc:Save/Restore additional SPRs for stop4 cpuidle
> >> 
> >> I know it's not a big deal, but can we agree on the subject format?
> >> 
> >>   powerpc/powernv: Save/Restore additional SPRs for stop4 cpuidle
> >
> > Sure. I will repost with the updated subject.
> 
> Sorry I had merged them, and fixed the subject up myself. But I didn't
> make that very clear in my mail.

Ah, ok! Thanks for fixing the subject line. I will keep the convention in
mind in the future.


> 
> So I've merged v3.
> 
> cheers
> 
--
Thanks and Regards
gautham.
