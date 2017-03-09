Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vf2wJ6PcmzDqXh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Mar 2017 19:04:00 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v297wsmc000899
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Mar 2017 03:03:51 -0500
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0a-001b2d01.pphosted.com with ESMTP id 292j704m9j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Mar 2017 03:03:51 -0500
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 9 Mar 2017 13:33:48 +0530
Received: from d28av07.in.ibm.com (d28av07.in.ibm.com [9.184.220.146])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2983kgu14221482
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Mar 2017 13:33:46 +0530
Received: from d28av07.in.ibm.com (localhost [127.0.0.1])
 by d28av07.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2983icA027215
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Mar 2017 13:33:46 +0530
Date: Thu, 9 Mar 2017 13:33:43 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 2/5] powerpc: kretprobes: override default function
 entry offset
References: <cover.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
 <53bcae5a711eab803c9c3210110e8a464df34202.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
 <87o9xcujzi.fsf@concordia.ellerman.id.au>
 <20170308142412.GI11046@naverao1-tp.localdomain>
 <20170308142916.GA3035@kernel.org>
 <20170308164644.GK11046@naverao1-tp.localdomain>
 <87a88vuf9p.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87a88vuf9p.fsf@concordia.ellerman.id.au>
Message-Id: <20170309080343.GA20400@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/03/09 05:37PM, Michael Ellerman wrote:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> > On 2017/03/08 11:29AM, Arnaldo Carvalho de Melo wrote:
> >> > I wasn't sure if you were planning on picking up KPROBES_ON_FTRACE for 
> >> > v4.11. If so, it would be good to take this patch through the powerpc 
> >> > tree. Otherwise, this can go via Ingo's tree.
> >> 
> >> If you guys convince Ingo that this should go _now_, then just cherry
> >> pick what was merged into tip/perf/core that is needed for the arch
> >> specific stuff and go from there.
> >
> > Ok, in hindsight, I think Michael's concern was actually for v4.12 
> 
> Yes I was talking about 4.12, sorry I thought that was implied :)

I suppose it was evident for everyone except the overzealous me :D
Sorry for all the confusion.

> 
> > itself, in which case this particular patch can go via powerpc tree, 
> > while the rest of the patches in this series can go via your tree.
> >
> > Michael?
> 
> Yeah I think that's the easiest option. The function will be temporarily
> unused until the two trees are merged, but I think that's fine.

Sure, thanks!

- Naveen
