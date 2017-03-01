Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYK471QqhzDqLB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 02:24:23 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v21FO3fv076509
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 10:24:21 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28wxrayjua-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Mar 2017 10:24:21 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 2 Mar 2017 01:24:18 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 43CDE3578056
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 02:24:16 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v21FO8oS54984826
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Mar 2017 02:24:16 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v21FNhbI029785
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Mar 2017 02:23:44 +1100
Date: Wed, 1 Mar 2017 20:53:25 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 1/2] powerpc: split ftrace bits into a separate file
References: <cover.1487702678.git.naveen.n.rao@linux.vnet.ibm.com>
 <d2058affbf317d0f72e2df970f97b7b53ade47cb.1487702678.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170227103650.0955c5eb@gandalf.local.home>
 <87wpcbota8.fsf@concordia.ellerman.id.au>
 <20170228091147.69b836a8@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170228091147.69b836a8@gandalf.local.home>
Message-Id: <20170301152325.GP4212@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/02/28 09:11AM, Steven Rostedt wrote:
> On Tue, 28 Feb 2017 15:04:15 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> kernel/trace/ftrace.c more obvious.
> > 
> > I don't know if it's really worth keeping the names the same across
> > arches, especially as we already have:
> > 
> >   arch/arm64/kernel/entry-ftrace.S
> >   arch/arm/kernel/entry-ftrace.S
> >   arch/blackfin/kernel/ftrace-entry.S
> >   arch/metag/kernel/ftrace_stub.S
> > 
> > But we can rename it if you feel strongly about it.
> 
> Hmm, perhaps "entry-ftrace.S" would be the better name. I never liked
> the "mcount.S" name.

Ok, just to be sure I get this right -- do you want me to name the 
powerpc files entry_ftrace_64.S (and subsequently to a slightly long 
entry_ftrace_64_mprofile.S), or rename the x86 mcount* files? Or both?

Thanks for the review,
- Naveen
