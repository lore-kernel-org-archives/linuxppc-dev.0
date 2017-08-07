Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xQmCd4483zDqkM
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 15:23:41 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v775JhZ4053245
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Aug 2017 01:23:38 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c65e9mwr1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Aug 2017 01:23:37 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 7 Aug 2017 01:23:36 -0400
Date: Mon, 7 Aug 2017 10:53:31 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87r2wvsgj1.fsf@concordia.ellerman.id.au>
Message-Id: <20170807052331.GA30140@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,


On Tue, Aug 01, 2017 at 08:56:18PM +1000, Michael Ellerman wrote:
> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
> >
> > Subject: [v3 PATCH 1/2] powernv/powerpc:Save/Restore additional SPRs for stop4 cpuidle
> 
> I know it's not a big deal, but can we agree on the subject format?
> 
>   powerpc/powernv: Save/Restore additional SPRs for stop4 cpuidle

Sure. I will repost with the updated subject.

> 
> cheers
> 
--
Thanks and Regards
gautham.
