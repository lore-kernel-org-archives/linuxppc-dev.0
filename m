Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXsM14lJPzDqcf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 17:35:25 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB66Xodt114859
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 01:35:23 -0500
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0a-001b2d01.pphosted.com with ESMTP id 275q0jmg20-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Dec 2016 01:35:23 -0500
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 6 Dec 2016 12:05:20 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 682EB125805C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 12:06:25 +0530 (IST)
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB66YgNG13500440
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 12:04:42 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB66ZEtW009420
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 12:05:17 +0530
Date: Tue, 6 Dec 2016 12:05:11 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, Ananth N <ananth@in.ibm.com>
Subject: Re: [PATCH] PPC: sstep.c: Add modsw, moduw instruction emulation
References: <20161204165521.10045-1-prasannatsmkumar@gmail.com>
 <20161205082357.GB3450@naverao1-tp.localdomain>
 <CANc+2y7OOPGz+Gjgp4A8DcAAJEL1qtStkKfrnhQecVZDCcTSmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANc+2y7OOPGz+Gjgp4A8DcAAJEL1qtStkKfrnhQecVZDCcTSmg@mail.gmail.com>
Message-Id: <20161206063511.GE3450@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/12/06 01:21AM, PrasannaKumar Muralidharan wrote:
> >> +
> >> +             case 267:       /* moduw */
> >
> > Please move this case further up so that the extended opcodes are in
> > numerical order.
> 
> Placed it after divide instruction as it appeared logical. Also placed
> 267 below 779 as it is the order in which the instructions are
> documented in the ISA book. This may help in finding related
> instructions together. If this style is not preferred I can arrange it
> in numerical order.

I guessed as much, but if you look at the existing function, you'll see 
that things have been arranged in numerical order. As such, it's best to 
stick to that convention.

- Naveen
