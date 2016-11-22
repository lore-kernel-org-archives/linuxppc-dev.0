Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNWKt0KNNzDvtd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 03:35:29 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAMGTXiL051253
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:35:27 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26vmjgsaxb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:35:27 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 22 Nov 2016 22:05:24 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 7596D125804F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 22:06:20 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAMGZLoo32702602
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 22:05:21 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAMGZJA8004825
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 22:05:21 +0530
Date: Tue, 22 Nov 2016 22:05:14 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCH] powerpc: split ftrace bits into a separate file
References: <20161122095532.21062-1-naveen.n.rao@linux.vnet.ibm.com>
 <20161122094617.43d050f0@gandalf.local.home>
 <20161122154318.GA29256@naverao1-tp.localdomain>
 <20161122104634.5c28c4b8@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161122104634.5c28c4b8@gandalf.local.home>
Message-Id: <20161122163514.GB29256@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/11/22 10:46AM, Steven Rostedt wrote:
> On Tue, 22 Nov 2016 21:13:18 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > Hi Steve,
> > 
> > On 2016/11/22 09:46AM, Steven Rostedt wrote:
> > > On Tue, 22 Nov 2016 15:25:32 +0530
> > > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > >   
> > > > No functional changes.  
> > > 
> > > Should have a better change log though. Why did you do this?
> > > 
> > > I'm personally fine with this, as long as the powerpc maintainers are
> > > too.  
> > 
> > Sure, thanks. Michael Ellerman wanted to split up entry_*.S:
> > https://marc.info/?l=linuxppc-embedded&m=147944810526787
> > 
> > I probably should have added a tag to indicate the same:
> > Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> > 
> 
> Yeah, and it there should be a small blurb about cleaning up entry_*.S,
> and this is just part of that clean up.

Done. I've sent a v2.

- Naveen
