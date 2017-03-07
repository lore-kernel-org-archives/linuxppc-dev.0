Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vd2Hc5nVDzDqXg
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 03:32:12 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v27G6Nqi087395
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Mar 2017 11:32:00 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29203eh906-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Mar 2017 11:32:00 -0500
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 7 Mar 2017 22:01:56 +0530
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v27GUk477798920
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Mar 2017 22:00:46 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v27GVrn8022175
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Mar 2017 22:01:54 +0530
Date: Tue, 7 Mar 2017 22:01:51 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 5/6] perf: probes: move ftrace README parsing logic into
 trace-event-parse.c
References: <cover.1488881988.git.naveen.n.rao@linux.vnet.ibm.com>
 <b5e4defdba760ea9a48681e3c3075b3517037008.1488881988.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170307165120.4e52fe447bd231d5e08a996f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170307165120.4e52fe447bd231d5e08a996f@kernel.org>
Message-Id: <20170307163151.GD11046@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/03/07 04:51PM, Masami Hiramatsu wrote:
> On Tue,  7 Mar 2017 16:17:40 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > probe-file.c needs libelf, but scanning ftrace README does not require
> > that. As such, move the ftrace README scanning logic out of probe-file.c
> > and into trace-event-parse.c.
> 
> As far as I can see, there is no reason to push this out from probe-file.c
> because anyway this API using code requires libelf. Without this, I can
> still build perf with NO_LIBELF=1. So I wouldn't like to pick this.
> (I think we can drop this from this series)

Ok. We can drop this. I'll rework patch 6/6.

Thanks,
Naveen
