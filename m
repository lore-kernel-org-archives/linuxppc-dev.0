Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ysP9L6hxYzDrpd
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Dec 2017 03:25:25 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB6GPFXA113971
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Dec 2017 11:25:22 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2eph2cv3pt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Dec 2017 11:25:18 -0500
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Wed, 6 Dec 2017 11:24:58 -0500
Subject: Re: what is the state about "[v2] ppc64 boot: Wait for boot cpu to
 show up if nr_cpus limit is about to hit"
To: Liu ping fan <kernelfans@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <CAFgQCTvOGfq2b861rgosCWD3EMNUOd-vVUp2K_sQYcWqeVepcQ@mail.gmail.com>
Cc: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 paulus <paulus@samba.org>
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Wed, 6 Dec 2017 14:24:50 -0200
MIME-Version: 1.0
In-Reply-To: <CAFgQCTvOGfq2b861rgosCWD3EMNUOd-vVUp2K_sQYcWqeVepcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <8c3d1f7d-f79b-8237-1a1c-97847a77804e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 11/28/2017 04:03 AM, Liu ping fan wrote:
> Hi,
> 
> I can not find the history about:
> https://patchwork.ozlabs.org/patch/577193/
> 
> 
> Can we have this patch?
> 
> Thanks,
> Pingfan
> 

Cross-referencing 2 threads on the same topic:
https://patchwork.ozlabs.org/patch/834860

Cascardo recently rebased this patch against latest kernel and tried to
get v3 merged, on the above linked thread.

Let's choose one of the threads to further discuss the solution to this
long-term bug!

Thanks,


Guilherme
